class Blog::Show < BrowserAction
  get "/blog/:slug" do
    html Blog::ShowPage
  end
end
