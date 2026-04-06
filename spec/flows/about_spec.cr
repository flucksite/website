require "../spec_helper"

describe "About page" do
  it "renders the hero section" do
    flow = BaseFlow.new

    flow.visit About::Index

    flow.should have_element("h1", text: Rosetta.find("about.index_page.hero.title").t.upcase)
    flow.should have_current_path(About::Index)
  end
end
