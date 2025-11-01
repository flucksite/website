class About::Index < BrowserAction
  get "/about", "/:locale/about" do
    html About::IndexPage
  end
end
