class Shared::LayoutHead < BaseComponent
  needs page_title : String

  def render
    head do
      utf8_charset
      title "My App - #{@page_title}"
      csrf_meta_tags
      responsive_meta_tag

      # Development helper used with the `lucky watch` command.
      # Reloads the browser when files are updated.
      live_reload_connect_tag if LuckyEnv.development?

      vite_client_tag
      vite_js_link "main.js", defer: true
      vite_css_links "main.js"
    end
  end
end
