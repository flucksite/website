require "../spec_helper"

describe "Home page" do
  it "renders the hero section" do
    flow = HomeFlow.new

    flow.visit_page

    title = Rosetta.find("home.index_page.hero.title").t.gsub("&nbsp;", " ").upcase
    flow.should have_element("h1", text: title)
    flow.should have_current_path(Home::Index)
  end

  it "subscribes to the waitlist" do
    flow = HomeFlow.new

    flow.visit_page
    flow.fill_waitlist_email("artist@example.com")
    flow.submit_waitlist_form

    flow.should have_element(".subscription-form__success")
  end

  it "shows a validation error for a missing email" do
    flow = HomeFlow.new

    flow.visit_page
    flow.submit_waitlist_form

    flow.should have_element(".field__error")
  end
end
