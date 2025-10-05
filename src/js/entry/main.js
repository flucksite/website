// Add this line to the beginning of every entry script
import 'vite/modulepreload-polyfill'

// Add static assets to the manifest (optional)
import.meta.glob([
  // '@images/**', // <- alias to src/images
  // '@fonts/**',  // <- alias to src/fonts
])

// Point to src/css/main.css
import '@css/main.css'

// Set up HTMX
import 'htmx.org'

// Set up Alpine
import Alpine from 'alpinejs'
import { registerAlpineExtensions } from '../utils/alpine-extensions'
window.Alpine = Alpine

registerAlpineExtensions(
  'data',
  import.meta.glob('@js/components/**/*.js', { eager: true }),
)

Alpine.start()
