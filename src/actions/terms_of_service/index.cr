class TermsOfService::Index < BrowserAction
  # get "/terms_of_service", "/:locale/terms_of_service" do
  get "/terms_of_service" do
    html TermsOfService::IndexPage
  end
end
