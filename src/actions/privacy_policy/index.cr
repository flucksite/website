class PrivacyPolicy::Index < BrowserAction
  get "/privacy_policy" do
    html PrivacyPolicy::IndexPage
  end
end
