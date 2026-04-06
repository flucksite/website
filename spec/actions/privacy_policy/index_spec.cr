require "../../spec_helper"

describe PrivacyPolicy::Index do
  it "renders successfully" do
    flow = BaseFlow.new

    flow.visit PrivacyPolicy::Index
    flow.should have_element("h1")
    flow.should have_current_path(PrivacyPolicy::Index)
  end
end
