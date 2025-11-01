class Waitlist::Index < BrowserAction
  get "/waitlist", "/:locale/waitlist" do
    html Waitlist::IndexPage
  end
end
