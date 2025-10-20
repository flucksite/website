class Waitlist::Index < BrowserAction
  get "/waitlist" do
    html Waitlist::IndexPage
  end
end
