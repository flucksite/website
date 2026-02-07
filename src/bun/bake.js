import {mkdirSync, readFileSync, existsSync, rmSync, watch} from 'fs'
import {join, dirname, basename, extname} from 'path'
import {Glob} from 'bun'

const LuckyBun = {
  CONFIG_PATH: 'config/bun.json',
  IGNORE_PATTERNS: [
    /^\d+$/,
    /^\.#/,
    /~$/,
    /\.swp$/,
    /\.swo$/,
    /\.tmp$/,
    /^#.*#$/,
    /\.DS_Store$/
  ],

  root: process.cwd(),
  config: null,
  manifest: {},
  dev: process.argv.includes('--dev'),
  wsClients: new Set(),

  // Safely load config file and fall back to defaults.
  loadConfig() {
    try {
      this.config = JSON.parse(
        readFileSync(join(this.root, this.CONFIG_PATH), 'utf-8')
      )
    } catch {
      this.config = {
        entryPoints: {
          js: ['src/js/app.js'],
          css: ['src/css/app.css']
        },
        outDir: 'public/assets',
        publicPath: '/assets'
      }
    }
  },

  // Returns the output directory.
  get outDir() {
    if (this.config == null) throw new Error(' ✖ Config is not loaded')

    return join(this.root, this.config.outDir)
  },

  // Fingerprints a file name, but only in production.
  fingerprint(name, ext, content) {
    if (this.dev) return `${name}${ext}`

    const hash = Bun.hash(content).toString(16).slice(0, 8)
    return `${name}-${hash}${ext}`
  },

  // Builds assets for a given file type (e.g. css or js/jsx/ts/tsx)
  async buildAssets(type, options = {}) {
    const outDir = join(this.outDir, type)
    mkdirSync(outDir, {recursive: true})

    const entries = this.config.entryPoints[type] || []
    const ext = `.${type}`

    for (const entry of entries) {
      const entryPath = join(this.root, entry)
      const entryName = basename(entry).replace(/\.(ts|js|tsx|jsx|css)$/, '')

      const result = await Bun.build({
        entrypoints: [entryPath],
        minify: !this.dev,
        ...options
      })

      if (!result.success) {
        console.error(` ▸ Failed to build ${entry}`)
        result.logs.forEach(log => console.error(log))
        continue
      }

      const output = result.outputs.find(o => o.path.endsWith(ext))
      if (!output) {
        console.error(` ▸ No ${type.toUpperCase()} output for ${entry}`)
        continue
      }

      const content = await output.text()
      const fileName = this.fingerprint(entryName, ext, content)
      await Bun.write(join(outDir, fileName), content)

      this.manifest[`${type}/${entryName}${ext}`] = `${type}/${fileName}`
    }
  },

  // Builds JS assets.
  async buildJS() {
    await this.buildAssets('js', {
      target: 'browser',
      format: 'iife',
      sourcemap: this.dev ? 'inline' : 'none'
    })
  },

  // Builds CSS assets.
  async buildCSS() {
    await this.buildAssets('css')
  },

  // Copies static assets to the output directory.
  async copyStaticAssets() {
    const dirs = this.config.staticDirs || ['src/images', 'src/fonts']
    const glob = new Glob('**/*.*')

    for (const dir of dirs) {
      const fullDir = join(this.root, dir)
      if (!existsSync(fullDir)) continue

      const assetType = basename(dir)
      const destDir = join(this.outDir, assetType)

      for await (const file of glob.scan({cwd: fullDir, onlyFiles: true})) {
        const srcPath = join(fullDir, file)
        const content = await Bun.file(srcPath).arrayBuffer()

        const ext = extname(file)
        const name = file.slice(0, -ext.length) || file
        const fileName = this.fingerprint(name, ext, new Uint8Array(content))
        const destPath = join(destDir, fileName)

        mkdirSync(dirname(destPath), {recursive: true})
        await Bun.write(destPath, content)

        this.manifest[`${assetType}/${file}`] = `${assetType}/${fileName}`
      }
    }
  },

  // Clears out the output directory.
  cleanOutDir() {
    rmSync(this.outDir, {recursive: true, force: true})
  },

  // Writes the asset manifest.
  async writeManifest() {
    mkdirSync(this.outDir, {recursive: true})
    await Bun.write(
      join(this.outDir, 'manifest.json'),
      JSON.stringify(this.manifest, null, 2)
    )
  },

  // Performs a full new build based on the current environment.
  async build() {
    const env = this.dev ? 'development' : 'production'
    console.log(`Building manifest for ${env}...`)
    const start = performance.now()
    this.loadConfig()
    this.cleanOutDir()
    await this.copyStaticAssets()
    await this.buildJS()
    await this.buildCSS()
    await this.writeManifest()
    const ms = Math.round(performance.now() - start)
    console.log(`DONE  Built successfully in ${ms} ms`, this.prettyManifest())
  },

  // Returns a printable version of the manifest.
  prettyManifest() {
    const lines = Object.entries(this.manifest)
      .map(([key, value]) => `  ${key} → ${value}`)
      .join('\n')
    return `\n${lines}\n\n`
  },

  // Sends a hot or cold reload command over WebSockets.
  reload(type = 'full') {
    setTimeout(() => {
      const message = JSON.stringify({type})
      for (const client of this.wsClients) {
        try {
          client.send(message)
        } catch {
          this.wsClients.delete(client)
        }
      }
    }, 50)
  },

  // Watches for file changes to rebuild the appropriate files.
  async watch() {
    const srcDir = join(this.root, 'src')

    watch(srcDir, {recursive: true}, async (event, filename) => {
      if (!filename) return

      const normalizedFilename = filename.replace(/\\/g, '/')
      const base = basename(normalizedFilename)
      const ext = extname(base).slice(1)

      if (this.IGNORE_PATTERNS.some(pattern => pattern.test(base))) return

      console.log(` ▸ ${normalizedFilename} changed`)

      try {
        if (ext === 'css') await this.buildCSS()
        else if (['js', 'ts', 'jsx', 'tsx'].includes(ext)) await this.buildJS()
        else if (base.includes('.')) await this.copyStaticAssets()

        await this.writeManifest()
        this.reload(ext === 'css' ? 'css' : 'full')
      } catch (err) {
        console.error(' ✖ Build error:', err.message)
      }
    })

    console.log('Beginning to watch your project')
  },

  // Starts the development server.
  async serve() {
    await this.build()
    await this.watch()

    const {host, port, secure} = this.config.devServer || {
      host: '127.0.0.1',
      port: 3002,
      secure: false
    }

    const wsClients = this.wsClients

    Bun.serve({
      hostname: secure ? '0.0.0.0' : host,
      port,
      fetch(req, server) {
        if (server.upgrade(req)) return
        return new Response('LuckyBun WebSocket Server', {status: 200})
      },
      websocket: {
        open(ws) {
          wsClients.add(ws)
          console.log(` ▸ Client connected (${wsClients.size})\n\n`)
        },
        close(ws) {
          wsClients.delete(ws)
          console.log(` ▸ Client disconnected (${wsClients.size})\n\n`)
        },
        message() {}
      }
    })

    const protocol = secure ? 'wss' : 'ws'
    console.log(`\n\n    🔌 Live reload at ${protocol}://${host}:${port}\n\n`)
  },

  // Main entry point to bake your Lucky Buns based on the current environment.
  async bake() {
    this.dev ? await this.serve() : await this.build()
  }
}

await LuckyBun.bake()
