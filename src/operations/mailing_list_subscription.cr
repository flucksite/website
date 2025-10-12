class MailingListSubscription < Avram::Operation
  attribute list : String
  attribute email : String

  def run
    validate_required email
    validate_format_of email, with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/
    validate_required list

    subscribe_user
  end

  private def subscribe_user
    EmailOctopus::Contact.create_or_update(
      api_client,
      list_id: list.value.to_s,
      email_address: email.value.to_s
    )
  end

  private def api_client
    EmailOctopus::Client.new(ENV.fetch("EMAIL_OCTOPUS_API_KEY"))
  end
end
