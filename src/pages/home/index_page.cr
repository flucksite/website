class Home::IndexPage < MainLayout
  def content
    render_hero
    render_usps
    render_callout
    render_features
    render_early_access
  end

  private def render_hero
    section class: "hero" do
      div class: "wrapper flow" do
        h1 do
          raw r(".hero.title").t
        end
        para r(".hero.text").t
      end
    end
  end

  private def render_usps
    section do
      div class: "wrapper" do
        ul role: "list", class: "switcher ", data_limit: 3 do
          {% for usp in %w[artists indie ownership] %}
            li class: "card" do
              h2 r(".usps.{{usp.id}}.title").t
              para r(".usps.{{usp.id}}.text").t
            end
          {% end %}
        end
      end
    end
  end

  private def render_callout
    section class: "callout | centered", data_max_width: "breakout" do
      div class: "cutout | switcher", data_shape: "rect-01", data_limit: 3 do
        h2 r(".creative_culture.title").t
        div
        div r(".creative_culture.text").t
      end
    end
  end

  private def render_features
    section class: "features" do
      div class: "wrapper flow" do
        h2 r(".features.title").t
        para r(".features.text").t, class: "features__text"

        ul role: "list", class: "grid", data_layout: "thirds" do
          {% for feature in %i[blog portfolio shop languages integrations builder] %}
            li class: "card", data_underline: true do
              h3 r(".features.{{feature.id}}.title").t
              para r(".features.{{feature.id}}.text").t
            end
          {% end %}
        end
      end
    end
  end

  private def render_early_access
    section class: "centered", data_max_with: "prose" do
      mount EarlyAccess
    end
  end
end
