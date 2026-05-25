# auto_register: false
# frozen_string_literal: true

require "hanami/action"
require "dry/monads"
require "fluck_website/actions/i18n_scope"
require "fluck_website/actions/rate_limit"

module FluckWebsite
  class Action < Hanami::Action
    extend Actions::RateLimit
    include Dry::Monads[:result]
    include Actions::I18nScope
  end
end
