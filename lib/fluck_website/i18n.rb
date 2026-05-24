# frozen_string_literal: true

require "i18n"

module FluckWebsite
  # Shared i18n facade: leading-dot keys resolve against the yielded scope.
  module I18n
    def self.t(key, **opts)
      key = "#{yield}#{key}" if block_given? && key.to_s.start_with?(".")
      ::I18n.t(key, **opts)
    end
  end
end
