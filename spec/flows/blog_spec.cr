require "../spec_helper"

describe "Blog page" do
  it "renders the hero section" do
    flow = BaseFlow.new

    flow.visit Blog::Index

    flow.should have_element("h1", text: Rosetta.find("blog.index_page.hero.title").t.upcase)
    flow.should have_current_path(Blog::Index)
  end

  it "lists the published blog posts" do
    flow = BaseFlow.new
    post = Blog::PostQuery.new.filter(&.active?).first

    flow.visit Blog::Index

    flow.should have_element("h2", text: post.title.upcase)
    flow.should have_element("a[href='#{Blog::Show.with(slug: post.slug).path}']")
  end

  it "filters blog posts by tag" do
    flow = BaseFlow.new
    tag = Blog::PostQuery.new.tags.first

    flow.visit Blog::Index.with(tag: tag)

    flow.should have_element("a.tag[aria-current='true']", text: tag)
  end
end

describe "Blog post page" do
  it "renders the post title, meta, and content" do
    flow = BaseFlow.new
    post = Blog::PostQuery.new.filter(&.active?).first

    flow.visit Blog::Show.with(slug: post.slug)

    flow.should have_element("h1", text: post.title.upcase)
    flow.should have_element("time[datetime='#{post.iso_date}']")
    flow.should have_element(".post__content")
    flow.should have_current_path(Blog::Show.with(slug: post.slug).path)
  end

  it "links back to the blog index when there is no newer post" do
    flow = BaseFlow.new
    newest_post = Blog::PostQuery.new.filter(&.active?).first

    flow.visit Blog::Show.with(slug: newest_post.slug)

    flow.should have_element("a[href='#{Blog::Index.path}']")
  end
end
