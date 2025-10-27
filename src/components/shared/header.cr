class Shared::Header < BaseComponent
  def render
    header class: "header wrapper" do
      div class: "repel" do
        render_logo
        render_nav
      end
    end
  end

  private def render_logo
    link to: Home::Index,
      class: "header__logo",
      aria_labelledby: "fluck_logo_label" do
      span "Fluck", class: "visually-hidden", id: "fluck_logo_label"
      inline_svg("fluck-logo-large-horizontal-transparent.svg")
      inline_svg("fluck-logo-large-vertical-transparent.svg")
    end
  end

  private def render_nav
    nav do
      ul class: "menu", data_direction: "horizontal" do
        {% for item in %i[about waitlist] %}
          li do
            link r("global.menu.item.{{item.id}}").t,
              to: action = {{item.id.camelcase}}::Index,
              aria_current: current_page?(action) ? "page" : "false"
          end
        {% end %}
        li do
          mount ThemeSwitcher
        end
      end
    end
  end
end
