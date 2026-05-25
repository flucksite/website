# frozen_string_literal: true

require "dry/inflector"
require "fluck_website/i18n"

module FluckWebsite
  module Actions
    # Derives i18n scope from an action's class; `t` resolves leading-dots.
    module I18nScope
      INFLECTOR = Dry::Inflector.new

      def self.scope_for(klass)
        parts = klass.name.split("::")
        idx = parts.index("Actions")
        return "" unless idx

        parts[(idx + 1)..].map { INFLECTOR.underscore(_1) }.join(".")
      end

      # Actions are frozen; memoize on the class since scope is fixed.
      def self.included(base)
        base.singleton_class.attr_accessor :i18n_scope
      end

      def t(key, **opts)
        FluckWebsite::I18n.t(key, **opts) { i18n_scope }
      end

      private

      def i18n_scope
        self.class.i18n_scope ||= I18nScope.scope_for(self.class)
      end
    end
  end
end
