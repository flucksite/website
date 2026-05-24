# frozen_string_literal: true

module FluckWebsite
  module Views
    module MailingLists
      class Create < FluckWebsite::View
        expose :list_tag
        expose :email_value
        expose :website_value
        expose :email_errors
        expose :success
      end
    end
  end
end
