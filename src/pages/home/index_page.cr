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
      h1 do
        raw r(".hero.title").t
      end
      para r(".hero.text").t
    end
  end

  private def render_usps
    section do
      ul role: "list", class: "features | el-switcher", data_limit: 3 do
        {% for usp in %w[artists indie ownership] %}
          li do
            h2 r(".usps.{{usp.id}}.title").t
            para r(".usps.{{usp.id}}.text").t
          end
        {% end %}
      end
    end
  end

  private def render_callout
    section do
      div class: "callout" do
        h2 r(".creative_culture.title").t
        para r(".creative_culture.text").t
      end
    end
  end

  private def render_features
    section do
      h2 r(".features.title").t
      para r(".features.text").t
      ul role: "list", class: "features | el-grid", data_layout: "thirds" do
        {% for feature in %i[blog portfolio shop languages integrations builder] %}
          li do
            h3 r(".features.{{feature.id}}.title").t
            para r(".features.{{feature.id}}.text").t
          end
        {% end %}
      end
    end
  end

  private def render_early_access
    section do
      mount EarlyAccess
    end
  end
end
