class Shared::SubscriptionForm < BaseComponent
  include Prosopo::Tags

  needs tag : String
  needs op : MailingListSubscription = MailingListSubscription.new(tag: tag)

  def render
    div id: dom_id, class: "subscription-form" do
      if op.valid? && op.email.value.presence
        render_success
      else
        render_form
      end
    end
  end

  private def render_form
    form_for MailingLists::Create, **hx_attrs do
      # lucky_prosopo_container
      hidden_input op.tag
      div class: "couple" do
        mount Shared::Field, op.email
        render_button
      end
      div class: "field visually-hidden" do
        label_for op.name, r("global.labels.honeypot").t
        text_input op.name
      end
    end
  end

  private def render_success
    div class: "subscription-form__success" do
      text r(".success").t(email: op.email.value.to_s)
    end
  end

  private def hx_attrs
    {
      hx_target:   "##{dom_id}",
      hx_select:   "##{dom_id}",
      hx_swap:     "outerHTML show:none",
      hx_push_url: false,
    }
  end

  private def dom_id
    @dom_id ||= "subscription_form_#{tag}"
  end

  private def render_button
    submit r(".button_variants").t(variant: tag), class: "button"
  end
end
