class Waitlist::IndexPage < MainLayout
  include Revealable

  def content
    render_hero
    render_form
    render_timeline
  end

  private def render_hero
    section class: "hero" do
      div class: "wrapper flow" do
        h1 r(".hero.title").t
        para r(".hero.text").t
      end
    end
  end

  private def render_form
    section class: "wrapper centered" do
      div class: "early-access cutout | flow",
        data_theme: "light",
        data_shape: "rect-02",
        data_safe: true do
        h2 r(".subscribe.title").t
        para r(".subscribe.text").t
        mount Shared::SubscriptionForm, tag: "waitlist"
      end
    end
  end

  private def render_timeline
    section class: "timeline | wrapper" do
      div **reveal_attr, class: "timeline__intro | flow reveal" do
        h2 r(".timeline.title").t
        para r(".timeline.text").t
      end

      {% for target in %w[
                         winter_2025_2026
                         spring_2026
                         summer_2026
                         public_beta_2
                         version_1
                       ] %}
        div **reveal_attr, class: "timeline__entry | flow reveal" do
          h3 r(".timeline.{{target.id}}.title").t
          div do
            markdown r(".timeline.{{target.id}}.text").t
          end 
        end
      {% end %}

      div **reveal_attr, class: "timeline__outro | reveal" do
        inline_svg("hurricane.svg")
      end
    end
  end
end
