require "../../spec_helper"

describe TermsOfService::Index do
  it "renders successfully" do
    response = AppClient.new.exec(TermsOfService::Index)

    response.status_code.should eq(200)
  end
end
