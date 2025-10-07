class MailingLists::Create < BrowserAction
  post "/mailing_lists" do
    MailingListSubscription.run(
      email: params.get(:email),
      list: "bla"
    ) do |op, results|
      if op.valid?
        plain_text "Render something in MailingLists::Create"
      else
        component Shared::SubscriptionForm, list: "newsletter"
      end
    end
  end
end
