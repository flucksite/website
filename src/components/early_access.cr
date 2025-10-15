class EarlyAccess < BaseComponent
  def render
    aside class: "early-access cutout | flow", data_shape: "rect-02" do
      h2 r(".title").t
      para r(".text").t
      para do
        strong r(".cta").t
      end
      mount Shared::SubscriptionForm, list: "waitlist"
      small r(".disclaimer").t
    end
  end
end
