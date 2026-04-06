require "../../spec_helper"

describe TermsOfService::Index do
  it "renders successfully" do
    flow = BaseFlow.new

    flow.visit TermsOfService::Index
    flow.should have_element("h1")
    flow.should have_current_path(TermsOfService::Index)
  end
end
