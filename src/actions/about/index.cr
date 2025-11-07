class About::Index < BrowserAction
  # get "/about", "/:locale/about" do
  get "/about" do
    html About::IndexPage
  end
end
