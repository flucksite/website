require "../../spec_helper"

describe About::Index do
  it "renders successfully" do
    flow = BaseFlow.new

    flow.visit About::Index
    flow.should have_element("h1", text: Rosetta.find("about.index_page.hero.title").t.upcase)
    flow.should have_current_path(About::Index)
  end
end
