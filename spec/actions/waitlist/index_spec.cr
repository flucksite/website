require "../../spec_helper"

describe Waitlist::Index do
  it "renders successfully" do
    response = AppClient.new.exec(Waitlist::Index)

    response.status_code.should eq(200)
  end
end
