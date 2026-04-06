require "../../spec_helper"

describe CodeOfConduct::Index do
  it "renders successfully" do
    response = AppClient.new.exec(CodeOfConduct::Index)

    response.status_code.should eq(200)
  end
end
