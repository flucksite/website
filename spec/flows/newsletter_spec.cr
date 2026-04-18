require "../spec_helper"

describe "Newsletter archive page" do
  it "renders the archive title and description" do
    flow = BaseFlow.new
    index = NewsletterQuery.index

    flow.visit Newsletter::Index

    flow.should have_element("h1", text: index.title.upcase)
    flow.should have_current_path(Newsletter::Index)
  end

  it "lists the published newsletters" do
    flow = BaseFlow.new
    newsletter = NewsletterQuery.new.filter(&.active?).first

    flow.visit Newsletter::Index

    flow.should have_element("h2", text: newsletter.title.upcase)
    flow.should have_element("a[href='#{Newsletter::Show.with(slug: newsletter.slug).path}']")
  end
end

describe "Newsletter show page" do
  it "renders the newsletter title, date, and content" do
    flow = BaseFlow.new
    newsletter = NewsletterQuery.new.filter(&.active?).first

    flow.visit Newsletter::Show.with(slug: newsletter.slug)

    flow.should have_element("h1", text: newsletter.title.upcase)
    flow.should have_element("time[datetime='#{newsletter.iso_date}']")
    flow.should have_element(".prose")
    flow.should have_current_path(Newsletter::Show.with(slug: newsletter.slug).path)
  end

  it "links back to the archive when there is no newer newsletter" do
    flow = BaseFlow.new
    newest = NewsletterQuery.new.filter(&.active?).first

    flow.visit Newsletter::Show.with(slug: newest.slug)

    flow.should have_element("a[href='#{Newsletter::Index.path}']")
  end

  it "links to the newer newsletter when one exists" do
    newsletters = NewsletterQuery.new.filter(&.active?).all
    pending! "requires at least two newsletters" if newsletters.size < 2

    flow = BaseFlow.new
    older = newsletters.last
    newer = newsletters[-2]

    flow.visit Newsletter::Show.with(slug: older.slug)

    flow.should have_element("a[href='#{Newsletter::Show.with(slug: newer.slug).path}']")
  end

  it "links to the older newsletter when one exists" do
    newsletters = NewsletterQuery.new.filter(&.active?).all
    pending! "requires at least two newsletters" if newsletters.size < 2

    flow = BaseFlow.new
    newest = newsletters.first
    older = newsletters[1]

    flow.visit Newsletter::Show.with(slug: newest.slug)

    flow.should have_element("a[href='#{Newsletter::Show.with(slug: older.slug).path}']")
  end
end
