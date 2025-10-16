class Shared::SubscriptionForm < BaseComponent
  include Prosopo::Tags

  needs tag : String
  needs op : MailingListSubscription = MailingListSubscription.new(tag: tag)

  def render
    div id: dom_id, class: "subscription-form" do
      form_for MailingLists::Create, **hx_attrs do
        # lucky_prosopo_container
        div class: "couple" do
          mount Shared::Field, op.email
          hidden_input(op.tag)
          render_button
        end
      end
    end
  end

  private def hx_attrs
    {
      hx_target:   "##{dom_id}",
      hx_swap:     "outerHTML show:none",
      hx_push_url: false,
    }
  end

  private def dom_id
    "subscription_form_#{tag}"
  end

  private def render_button
    submit r(".button_variants").t(variant: tag), class: "button"
  end
end
