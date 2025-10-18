class MailingLists::Create < BrowserAction
  include Lucky::RateLimit

  rate_limit to: 5, within: 1.minute
  before reject_filled_honeypot

  post "/mailing_lists" do
    MailingListSubscription.run(params) do |op, results|
      html MailingLists::CreatePage, op: op
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
