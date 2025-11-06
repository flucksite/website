class Shared::Header < BaseComponent
  def render
    header class: "header wrapper" do
      div class: "repel" do
        render_logo
        div class: "flow" do
          render_actions
          mount MainMenu
        end
      end
    end
  end

  private def render_logo
    localink to: Home::Index,
      class: "header__logo",
      aria_labelledby: "fluck_logo_label" do
      span "Fluck", class: "visually-hidden", id: "fluck_logo_label"
      inline_svg("fluck-logo-large-horizontal-transparent.svg")
      inline_svg("fluck-logo-large-vertical-transparent.svg")
    end
  end

  private def render_actions
    div class: "preferences" do
      mount LocaleSwitcher
      mount ThemeSwitcher
    end
  end
end
