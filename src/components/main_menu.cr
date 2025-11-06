class MainMenu < BaseComponent
  MENU_ITEMS = %i[about waitlist]

  def render
    nav class: "main-menu", aria_labelledby: "main_nav_label" do
      span r(".title").t, hidden: true, id: "main_nav_label"
      ul class: "menu", data_direction: "horizontal" do
        {% for item in MENU_ITEMS %}
          {% action = "#{item.id.camelcase}::Index".id %}
          li do
            localink r("global.menu.item.{{item.id}}").t,
              to: {{action}},
              aria_current: current_page?({{action}}) ? "page" : "false"
          end
        {% end %}
      end
    end
  end
end
