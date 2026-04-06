require "../spec_helper"

describe "Blog page" do
  it "renders the hero section" do
    flow = BaseFlow.new

    flow.visit Blog::Index

    flow.should have_element("h1", text: Rosetta.find("blog.index_page.hero.title").t.upcase)
    flow.should have_current_path(Blog::Index)
  end
end
