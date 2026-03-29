require "../../spec_helper"

describe PrivacyPolicy::Index do
  it "renders successfully" do
    response = HtmlClient.new.exec(PrivacyPolicy::Index)

    response.status_code.should eq(200)
  end
end
