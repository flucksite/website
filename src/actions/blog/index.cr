class Blog::Index < BrowserAction
  get "/blog" do
    html Blog::IndexPage
  end
end
