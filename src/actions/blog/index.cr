class Blog::Index < BrowserAction
  include Lucky::Paginator::BackendHelpers

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
    plain_text Blog::RssFeedPage.new(all_posts.first(50)).to_xml,
      content_type: "application/rss+xml; charset=utf-8"
  end

  private def html_page
    pages, posts = paginate_array(all_posts, per_page: 10)
    html Blog::IndexPage,
      current_tag: tag,
      posts: posts,
      pages: pages,
      blog: Blog::PostQuery.index,
      all_tags: Blog::PostQuery.new.tags
  end

  private def all_posts
    filtered = Blog::PostQuery.new.filter(&.active?)
    filtered = filtered.filter(&.tags.includes?(tag)) if tag
    filtered.all
  end
end
