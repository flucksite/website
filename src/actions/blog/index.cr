class Blog::Index < BrowserAction
  accepted_formats [:html, :rss], default: :html

  param tag : String? = nil

  get "/blog" do
    return rss_feed if request.path.ends_with?(".rss")

    html Blog::IndexPage, tag: tag, posts: posts, index: index
  end

  private def rss_feed
    plain_text Blog::RssFeedPage.new(posts).to_xml,
      content_type: "application/rss+xml; charset=utf-8"
  end

  private def posts
    filtered = Blog::PostQuery.new.filter(&.active?)
    filtered = filtered.filter(&.tags.includes?(tag)) if tag
    filtered.all
  end

  private def index
    Blog::PostQuery.index
  end
end
