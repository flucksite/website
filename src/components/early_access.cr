class EarlyAccess < BaseComponent
  def render
    aside do
      h2 r(".title").t
      para r(".text").t
      strong r(".cta").t
      mount Shared::SubscriptionForm, list: "waitlist"
      small r(".disclaimer").t
    end
  end
end
