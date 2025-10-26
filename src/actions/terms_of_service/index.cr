class TermsOfService::Index < BrowserAction
  get "/terms_of_service" do
    html TermsOfService::IndexPage
  end
end
