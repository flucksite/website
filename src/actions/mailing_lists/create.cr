class MailingLists::Create < BrowserAction
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
end
