class Shared::SubscriptionForm < BaseComponent
  include Prosopo::Tags

  needs tag : String
  needs op : MailingListSubscription = MailingListSubscription.new(tag: tag)

  def render
    turbo_frame id: "subscription_form_#{tag}" do
      div class: "subscription-form" do
        if op.valid? && op.email.value.presence
          render_success
        else
          render_form
        end
      end
    end
  end

  private def render_form
    form_for MailingLists::Create do
      # lucky_prosopo_container
      hidden_input op.tag
      if tag == "waitlist"
        mount Shared::Field, op.website, r("global.labels.website").t
      end
      div class: "couple" do
        email_field
        render_button
      end
      honeypot_field
    end
  end

  private def email_field
    dom_id = "#{tag}_email"
    div class: "field" do
      label_for op.email, for: dom_id
      email_input op.email, id: dom_id
      mount Shared::FieldErrors, op.email
    end
  end

  private def honeypot_field
    div class: "field visually-hidden" do
      dom_id = "#{tag}_name"
      label_for op.name, r("global.labels.honeypot").t, for: dom_id
      text_input op.name, id: dom_id
    end
  end

  private def render_success
    div class: "subscription-form__success" do
      text r(".success").t(email: op.email.value.to_s)
    end
  end

  private def render_button
    submit r(".button_variants").t(variant: tag), class: "button"
  end
end
