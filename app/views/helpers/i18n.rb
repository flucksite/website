# auto_register: false
# frozen_string_literal: true

require "fluck_website/i18n"

module FluckWebsite
  module Views
    module Helpers
      module I18n
        # Leading-dot keys resolve against the view's i18n_scope.
        def t(key, **opts)
          FluckWebsite::I18n.t(key, **opts) { i18n_scope }
        end

        def l(value, **opts)
          ::I18n.l(value, **opts)
        end
      end
    end
  end
end
