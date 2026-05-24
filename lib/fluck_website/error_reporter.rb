# frozen_string_literal: true

module FluckWebsite
  # Sends exceptions to Sentry when initialized; otherwise a silent no-op.
  module ErrorReporter
    def self.report(exception)
      return unless defined?(Sentry) && Sentry.initialized?

      Sentry.capture_exception(exception)
    end
  end
end
