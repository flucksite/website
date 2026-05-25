# auto_register: false
# frozen_string_literal: true

module FluckWebsite
  module Views
    module Helpers
      # Renders Hanami's CSRF token as a hidden input; pair with non-GET forms.
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
