require "../../spec_helper"

describe Home::Index do
  it "renders successfully" do
    response = HtmlClient.new.exec(Home::Index)

    response.status_code.should eq(200)
  end
end
