class Waitlist::IndexPage < MainLayout
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
    mount Shared::SubscriptionForm, tag: "waitlist"
  end

  private def render_timeline
  end
end
