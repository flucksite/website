class Shared::Footer < BaseComponent
  def render
    render_info_menu
    render_social_menu
    mount Shared::SubscriptionForm, list: "newsletter"
  end

  private def render_info_menu
  end

  private def render_social_menu
  end
end
