class Shared::SubscriptionForm < BaseComponent
  include Prosopo::Tags

  needs list : String
  needs op : MailingListSubscription = MailingListSubscription.new

  def render
    div do
      form_for MailingLists::Create do
        # lucky_prosopo_container
        mount Shared::Field, op.email
      end
    end
  end
end
