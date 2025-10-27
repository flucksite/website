class Shared::LayoutHead < BaseComponent
  include LuckyFavicon::Tags
  include Prosopo::Tags

  FLUCK = "FLUCK"

  needs page_title : String
  needs page_description : String

  def render
    head do
      utf8_charset
      title "#{@page_title} – #{FLUCK}"
      meta name: "description", content: @page_description
      meta name: "robots", content: "noai, noimageai"
      canonical_link current_url
      og_tags
      twitter_card_tags
      csrf_meta_tags
      responsive_meta_tag
      favicon_tags app_name: FLUCK
      preload_backgrounds

      # Development helper used with the `lucky watch` command.
      # Reloads the browser when files are updated.
      live_reload_connect_tag if LuckyEnv.development?

      turbo_morph_tag
      turbo_view_transition_tag
      lucky_prosopo_script
      plausible_script
      vite_client_tag if LuckyEnv.production?
      vite_js_link "main.js", defer: true
      vite_css_links "main.js"
    end
  end

  private def og_tags
    meta property: "og:url", content: current_url
    meta property: "og:site_name", content: FLUCK
    meta property: "og:title", content: @page_title
    meta property: "og:description", content: @page_description
    meta property: "og:image", content: og_image_url
    meta property: "og:image:width", content: 1200
    meta property: "og:image:height", content: 630
  end

  private def og_image_url
    asset "@images/social/fluck-og-image.png"
  end

  private def twitter_card_tags
    meta name: "twitter:card", content: "summary_large_image"
  end

  macro preload_backgrounds
    {% for background in %w[waitlist-light waitlist-dark error] %}
      empty_tag "link",
        rel: "preload",
        as: "image",
        type: "image/svg+xml",
        href: asset("@images/backgrounds/{{background.id}}.svg")
    {% end %}
  end

  private def plausible_script
    script src: "https://plausible.io/js/plausible.js",
      async: true,
      defer: true,
      data_domain: app_domain
  end

  private def current_url
    "https://#{app_domain}#{context.request.resource}"
  end

  private def app_domain
    ENV.fetch("APP_DOMAIN", "fluck.site")
  end
end
