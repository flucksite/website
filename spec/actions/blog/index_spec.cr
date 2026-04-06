require "../../spec_helper"

describe Blog::Index do
  it "renders successfully" do
    flow = BaseFlow.new

    flow.visit Blog::Index
    flow.should have_element("h1", text: Rosetta.find("blog.index_page.hero.title").t.upcase)
    flow.should have_current_path(Blog::Index)
  end
end
