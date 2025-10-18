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

  private def render_button
    submit r(".button_variants").t(variant: tag), class: "button"
  end
end
