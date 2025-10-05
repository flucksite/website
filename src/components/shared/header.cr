class Shared::Header < BaseComponent
  def render
    header class: "header" do
      link to: Home::Index do
        span "Fluck", class: "visually-hidden"
        inline_svg("fluck-logo-dark-large-horizontal-transparent.svg")
      end
      nav do
        ul role: "list" do
          li do
            link r("global.menu.item.about").t, to: About::Index
          end
          li do
            link r("global.menu.item.waitlist").t, to: About::Index
          end
        end
      end
    end
  end
end
