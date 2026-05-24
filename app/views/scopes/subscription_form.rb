# auto_register: false
# frozen_string_literal: true

module FluckWebsite
  module Views
    module Scopes
      class SubscriptionForm < Hanami::View::Scope
        def email_dom_id   = "#{list_tag}_email"
        def website_dom_id = "#{list_tag}_website"

        def submit_label
          t("shared.subscription_form.button_variants.#{list_tag}")
        end

        def success_message
          t("shared.subscription_form.success", email: email_value)
        end

        def email_label
          t("global.labels.email", default: "Email")
        end

        def website_label
          t("global.labels.website")
        end
      end
    end
  end
end
