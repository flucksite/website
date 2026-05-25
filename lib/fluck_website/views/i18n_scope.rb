# frozen_string_literal: true

require "dry/inflector"

module FluckWebsite
  module Views
    # Derives i18n scope from a view's class name; last segment gets "_page".
    module I18nScope
      INFLECTOR = Dry::Inflector.new

      def self.scope_for(klass)
        parts = klass.name.split("::")
        idx = parts.index("Views")
        return [] unless idx

        segments = parts[(idx + 1)..].map { INFLECTOR.underscore(_1) }
        return [] if segments.empty?

        segments[-1] = "#{segments[-1]}_page"
        segments
      end

      def self.scope_string_for(klass)
        scope_for(klass).join(".")
      end

      def self.page_key_for(klass)
        parts = klass.name.split("::")
        idx = parts.index("Views")
        return nil unless idx

        parts[(idx + 1)..-2].map { INFLECTOR.underscore(_1) }.join("/")
      end

      def self.included(base)
        base.expose :i18n_scope, layout: true do
          I18nScope.scope_string_for(self.class)
        end

        base.expose :title, layout: true do
          scope = I18nScope.scope_string_for(self.class)
          ::I18n.t("#{scope}.page_title", default: nil)
        end

        base.expose :description, layout: true do
          scope = I18nScope.scope_string_for(self.class)
          ::I18n.t("#{scope}.page_description", default: nil)
        end

        base.expose :page_key, layout: true do
          I18nScope.page_key_for(self.class)
        end
      end
    end
  end
end
