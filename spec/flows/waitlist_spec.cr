require "../spec_helper"

describe "Waitlist page" do
  it "renders the hero section" do
    flow = BaseFlow.new

    flow.visit Waitlist::Index

    flow.should have_element("h1", text: Rosetta.find("waitlist.index_page.hero.title").t.upcase)
    flow.should have_current_path(Waitlist::Index)
  end
end
