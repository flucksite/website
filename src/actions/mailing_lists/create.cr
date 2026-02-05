class MailingLists::Create < BrowserAction
  include Lucky::RateLimit
  include LuckyHoneypot::Pipe

  rate_limit to: 5, within: 1.minute
  honeypot "mailing_list_subscription:name"

  post "/mailing_lists" do
    MailingListSubscription.run(params) do |op, results|
      html_with_status MailingLists::CreatePage, op.valid? ? 200 : 422, op: op
    end
  end
end
