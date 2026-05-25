# frozen_string_literal: true

require "fluck_website/types"

module FluckWebsite
  # Settings read uppercased ENV via Hanami's EnvStore; constructor is explicit.
  class Settings < Hanami::Settings
    setting :app_domain, default: "fluck.site", constructor: Types::String

    # EmailOctopus newsletter API: EMAIL_OCTOPUS_API_KEY, EMAIL_OCTOPUS_LIST_ID
    setting :email_octopus_api_key, constructor: Types::String.optional
    setting :email_octopus_list_id, constructor: Types::String.optional

    # Sentry error reporting: SENTRY_DSN (no-op when unset)
    setting :sentry_dsn, constructor: Types::String.optional

    # Plausible analytics: PLAUSIBLE_DOMAIN (script-tag domain, prod-only)
    setting :plausible_domain, constructor: Types::String.optional
    setting :plausible_script_src,
            default: "https://plausible.io/js/script.outbound-links.js",
            constructor: Types::String
  end
end
