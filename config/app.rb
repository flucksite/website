# frozen_string_literal: true

begin
  require "dotenv/load"
rescue LoadError
  # dotenv is dev/test-only; production sets ENV directly.
end

require "bun_bun_bundle"
require "hanami"
require "marquery/asset_handler"

require_relative "log_templates"

module FluckWebsite
  class App < Hanami::App
    BunBunBundle.setup(root: root, hanami: config)

    # Fonts are embedded as data: URIs in the bundled CSS (woff2 base64).
    config.actions.content_security_policy[:font_src] = "'self' data:"

    # Alpine needs 'unsafe-eval'; otori + plausible need 'unsafe-inline'.
    config.actions.content_security_policy[:script_src] =
      "'self' 'unsafe-inline' 'unsafe-eval' https://plausible.io"

    # ws://localhost lets bun_bun_bundle's HMR socket through in dev.
    config.actions.content_security_policy[:connect_src] =
      "'self' https://plausible.io ws://127.0.0.1:* ws://localhost:*"

    config.logger.options = {colorize: true}

    # CSRF + otori need a session. Prod must set SESSION_SECRET.
    config.actions.sessions = :cookie, {
      key: "fluck.session",
      secret: ENV.fetch("SESSION_SECRET") {
        raise "SESSION_SECRET must be set in production" if ENV["HANAMI_ENV"] == "production"

        SecureRandom.hex(32)
      },
      expire_after: 60 * 60 * 24 * 365
    }

    # Serves markdown post assets (images/etc.) from data/blog_post.
    config.middleware.use(
      Marquery::AssetHandler,
      File.expand_path("data/blog_post", root)
    )

    require "rack/attack"
    require_relative "rack_attack"
    config.middleware.use Rack::Attack

    # Serves public/ directly; front with a reverse proxy in prod.
    config.middleware.use(
      Rack::Static,
      urls: %w[
        /assets
        /robots.txt
        /sitemap.xml
        /favicon.ico
        /favicon.svg
        /favicon-96x96.png
        /apple-touch-icon.png
        /site.webmanifest
        /web-app-manifest-192x192.png
        /web-app-manifest-512x512.png
      ],
      root: "public"
    )
  end
end
