class Waitlist::Index < BrowserAction
  # get "/waitlist", "/:locale/waitlist" do
  get "/waitlist" do
    html Waitlist::IndexPage
  end
end
