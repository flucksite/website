require "../../spec_helper"

describe About::Index do
  it "renders successfully" do
    response = AppClient.new.exec(About::Index)

    response.status_code.should eq(200)
  end
end
