class HomeFlow < BaseFlow
  def visit_page
    visit Home::Index
  end

  def fill_waitlist_email(email : String)
    fill el("#waitlist_email"), with: email
  end

  def submit_waitlist_form
    el("#subscription_form_waitlist input[type='submit']").click
  end
end
