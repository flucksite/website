class MailingLists::CreatePage < MainLayout
  needs op : MailingListSubscription

  def content
    mount Shared::SubscriptionForm, op: op, tag: op.tag.value.to_s
  end
end
