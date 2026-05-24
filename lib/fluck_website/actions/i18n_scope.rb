# frozen_string_literal: true

require "dry/inflector"
require "fluck_website/i18n"

module FluckWebsite
  module Actions
    # Derives an i18n scope from an action's class name and adds a `t` helper
    # that resolves leading-dot keys against that scope.
    #
    #   FluckWebsite::Actions::MailingLists::Create -> "mailing_lists.create"
    #   FluckWebsite::Actions::Blog::Show           -> "blog.show"
    #
    # In templates, leading-dot keys resolve against the *view's* scope (which
    # appends `_page`). Here they resolve against the action's scope, matching
    # the way action-level error messages are nested under `actions.en.yml`.
    module I18nScope
      INFLECTOR = Dry::Inflector.new

      def self.scope_for(klass)
        parts = klass.name.split("::")
        idx = parts.index("Actions")
        return "" unless idx

        parts[(idx + 1)..].map { INFLECTOR.underscore(_1) }.join(".")
      end

      # Hanami freezes action instances post-init, so we can't memoize on @ivars.
      # Class-level memoization is fine since the scope is fixed per class.
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
