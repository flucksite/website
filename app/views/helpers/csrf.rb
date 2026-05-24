# auto_register: false
# frozen_string_literal: true

module FluckWebsite
  module Views
    module Helpers
      # Renders Hanami's per-session CSRF token as a hidden form input. Pair with
      # any non-GET form so the request passes `Hanami::Action::CSRFProtection`.
      module Csrf
        def csrf_field
          tag.input(
            type: "hidden",
            name: Hanami::Action::CSRFProtection::CSRF_TOKEN.to_s,
            value: csrf_token
          )
        end
      end
    end
  end
end
