class Shared::LayoutHead < BaseComponent
  include LuckyFavicon::Tags

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

      vite_client_tag
      vite_js_link "main.js", defer: true
      vite_css_links "main.js"
    end
  end
end
