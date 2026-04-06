require "../../spec_helper"

describe Blog::Index do
  it "renders successfully" do
    response = AppClient.new.exec(Blog::Index)

    response.status_code.should eq(200)
  end
end
