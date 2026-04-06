require "../spec_helper"

describe "Code of Conduct page" do
  it "renders successfully" do
    flow = BaseFlow.new

    flow.visit CodeOfConduct::Index

    flow.should have_element("h1")
    flow.should have_current_path(CodeOfConduct::Index)
  end
end
