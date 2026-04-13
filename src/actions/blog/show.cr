class Blog::Show < BrowserAction
  get "/blog/:slug" do
    html Blog::ShowPage,
      post: find_post,
      query: Blog::PostQuery.new
  end

  private def find_post
    Blog::PostQuery.new.find(params.get(:slug))
  end
end
