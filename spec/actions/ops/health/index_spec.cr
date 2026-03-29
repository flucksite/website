require "../../../spec_helper"

describe Ops::Health::Index do
  it "returns ok" do
    response = ApiClient.new.exec(Ops::Health::Index)

    response.status_code.should eq(200)
    response.body.should eq("ok")
  end
end
