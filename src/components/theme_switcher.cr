class ThemeSwitcher < BaseComponent
  def render
    div class: "theme-switcher" do
      button type: "button",
        "@click": "toggleTheme()" do
        span r(".toggle").t, class: "visually-hidden"
        inline_svg("theme/light.svg")
        inline_svg("theme/dark.svg")
      end
    end
  end
end
