class Home::Index < BrowserAction
  # get "/", "/:locale" do
  get "/" do
    html Home::IndexPage
  end
end
