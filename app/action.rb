# auto_register: false
# frozen_string_literal: true

require "hanami/action"
require "rack/attack"
require "dry/monads"
require "fluck_website/actions/i18n_scope"

module FluckWebsite
  class Action < Hanami::Action
    include Dry::Monads[:result]
    include Actions::I18nScope

    # Registers a ::Rack::Attack throttle scoped to this action's method+path.
    def self.rate_limit(method:, path:, limit:, period:, by: ->(req) { req.ip })
      ::Rack::Attack.throttle("#{name}/#{by.object_id}", limit: limit, period: period) do |req|
        by.call(req) if req.request_method.casecmp?(method.to_s) && req.path == path
      end
    end
  end
end
