require "../../spec_helper"

describe Home::Index do
  it "renders successfully" do
    flow = BaseFlow.new

    flow.visit Home::Index
    title = Rosetta.find("home.index_page.hero.title").t.gsub("&nbsp;", " ").upcase
    flow.should have_element("h1", text: title)
    flow.should have_current_path(Home::Index)
  end
end
