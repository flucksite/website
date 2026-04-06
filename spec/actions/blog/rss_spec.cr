require "../../spec_helper"

describe "Blog RSS feed" do
  it "renders an RSS feed" do
    response = AppClient.new.get("/blog.rss")

    response.status_code.should eq(200)
    response.headers["Content-Type"].should contain("application/rss+xml")
    response.body.should contain("<rss")
    response.body.should contain("<channel>")
  end

  it "includes blog posts" do
    response = AppClient.new.get("/blog.rss")

    response.body.should contain("<item>")
    response.body.should contain("The very first post")
  end
end
