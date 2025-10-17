class MailingLists::Create < BrowserAction
  include Lucky::RateLimit

  rate_limit to: 5, within: 1.minute
  before reject_filled_honeypot

  post "/mailing_lists" do
    MailingListSubscription.run(params) do |op, results|
      if op.valid?
        plain_text "Render something in MailingLists::Create"
      else
        component Shared::SubscriptionForm,
          op: op,
          tag: op.tag.value.to_s,
          status: 422
      end
    end
  end

  private def reject_filled_honeypot
    if honeypot_param.try(&.presence)
      head 200
    else
      continue
    end
  end

  private def honeypot_param
    params.get("mailing_list_subscription:name")
  end
end
