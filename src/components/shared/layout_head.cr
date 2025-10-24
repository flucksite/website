class Shared::LayoutHead < BaseComponent
  include LuckyFavicon::Tags
  include Prosopo::Tags

  needs page_title : String
  needs page_description : String

  def render
    head do
      utf8_charset
      title "#{@page_title} – FLUCK"
      meta name: "description", content: @page_description
      csrf_meta_tags
      responsive_meta_tag
      favicon_tags app_name: "FLUCK"

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

  private def plausible_script
    script src: "https://plausible.io/js/plausible.js",
      async: true,
      defer: true,
      data_domain: app_domain
  end

  private def app_domain
    ENV.fetch("APP_DOMAIN", "fluck.site")
  end
end
