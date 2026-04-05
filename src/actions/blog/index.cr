class Blog::Index < BrowserAction
  accepted_formats [:html, :rss], default: :html

  get "/blog" do
    return rss_feed if request.path.ends_with?(".rss")

    html Blog::IndexPage
  end

  private def rss_feed
    plain_text Blog::RssFeedPage.new(marquery_posts).to_xml,
      content_type: "application/rss+xml; charset=utf-8"
  end

  private def marquery_posts
    Blog::PostQuery.new.filter(&.active?).all
  end
end
