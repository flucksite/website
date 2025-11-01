class Home::Index < BrowserAction
  get "/", "/:locale" do
    html Home::IndexPage
  end
end
