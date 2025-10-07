class MailingListSubscription < Avram::Operation
  attribute list : String
  attribute email : String

  def run
    validate_format_of email, with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/

    # Subscribe user
  end
end
