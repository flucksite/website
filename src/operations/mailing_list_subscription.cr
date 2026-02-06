class MailingListSubscription < Avram::Operation
  attribute tag : String
  attribute email : String
  attribute name : String
  attribute website : String
  attribute signals : String

  before_run do
    validate_required email
    validate_format_of email, with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/
    validate_required tag
    validate_inclusion_of tag, in: %w[newsletter waitlist]
  end

  def run
    subscribe_user
  end

  private def subscribe_user
    EmailOctopus::Contact.create_or_update(
      list_id: list_id,
      email_address: email.value.to_s,
      fields: {"Website" => website.value.to_s, "Signals" => signals.value.to_s},
      tags: {tag.value.to_s => true, "review" => needs_review?}
    )
  rescue ex : Exception
    Raven.capture(ex)
  end

  private def list_id
    ENV.fetch("EMAIL_OCTOPUS_LIST_ID")
  end

  private def needs_review? : Bool
    return false unless json = signals.value.to_s

    LuckyHoneypot::Signals.human_rating(json) < 0.5
  end
end
