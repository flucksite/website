# frozen_string_literal: true

require "fluck_website/error_reporter"

module FluckWebsite
  module MailingLists
    # Validates input and forwards a subscription to EmailOctopus.
    class Subscribe < FluckWebsite::Operation
      include Deps["email_octopus"]

      EMAIL_FORMAT = /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/
      TAGS = %w[newsletter waitlist].freeze
      REVIEW_THRESHOLD = 0.4

      def call(tag:, email:, website:, signals_rating:)
        email = email.strip
        website = website.strip

        step validate_tag(tag)
        step validate_email(email)
        step subscribe_contact(tag, email, website, signals_rating)

        # dry-operation wraps this return value in Success
        {email: email}
      end

      private

      def validate_tag(tag)
        TAGS.include?(tag) ? Success() : Failure(:invalid_tag)
      end

      def validate_email(email)
        email.match?(EMAIL_FORMAT) ? Success() : Failure(:invalid_email)
      end

      def subscribe_contact(tag, email, website, rating)
        email_octopus.subscribe(
          email: email,
          tag: {tag => true, "review" => rating < REVIEW_THRESHOLD},
          fields: {"Website" => website, "Signals" => rating.to_s}
        )
        Success()
      rescue StandardError => exception
        ErrorReporter.report(exception)
        Failure(:subscription_failed)
      end
    end
  end
end
