class About::Index < BrowserAction
  get "/about" do
    html About::IndexPage
  end
end
