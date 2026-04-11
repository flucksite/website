class Blog::Index < BrowserAction
  accepted_formats [:html, :rss], default: :html

  param tag : String? = nil

  get "/blog" do
    if accepts?(:rss)
      rss_feed
    else
      html_page
    end
  end

  private def rss_feed
    plain_text Blog::RssFeedPage.new(posts).to_xml,
      content_type: "application/rss+xml; charset=utf-8"
  end

  private def html_page
    html Blog::IndexPage,
      current_tag: tag,
      posts: posts,
      blog: Blog::PostQuery.index,
      all_tags: Blog::PostQuery.new.tags
  end

  private def posts
    filtered = Blog::PostQuery.new.filter(&.active?)
    filtered = filtered.filter(&.tags.includes?(tag)) if tag
    filtered.all
  end
end
