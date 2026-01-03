class Home::IndexPage < MainLayout
  include Revealable

  FEATURES = %i[blog portfolio shop languages integrations builder]
  USPS     = %w[artists indie ownership]

  def content
    render_hero
    render_usps
    render_callout
    render_features
    render_early_access
  end

  private def render_hero
    section class: "hero", data_layout: "home" do
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
          {% for usp, index in USPS %}
            li **reveal_attr(start: "right", speed: RevealSpeed.from_value({{index + 1}})),
              class: "card | reveal" do
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
      div **reveal_attr(start: "down"),
        class: "cutout | switcher reveal",
        data_shape: "rect-01",
        data_safe: true,
        data_limit: 3 do
        h2 r(".creative_culture.title").t
        div
        div r(".creative_culture.text").t
      end
    end
  end

  private def render_features
    section class: "features" do
      div **reveal_attr(start: "right"), class: "wrapper flow | reveal" do
        h2 r(".features.title").t
        para r(".features.text").t, class: "features__text"

        ul role: "list", class: "grid", data_layout: "thirds" do
          {% for feature, index in FEATURES %}
            li **reveal_attr(start: "right", speed: RevealSpeed.from_value({{index % 3 + 1}})),
              class: "card | reveal",
              data_underline: true do
              h3 r(".features.{{feature.id}}.title").t
              para r(".features.{{feature.id}}.text").t
            end
          {% end %}
        end
      end
    end
  end
end
