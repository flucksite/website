# frozen_string_literal: true

require "dry/inflector"
require "rack/attack"

module FluckWebsite
  module Actions
    module RateLimit
      INFLECTOR = Dry::Inflector.new

      REST_METHODS = Hash.new("GET").merge!(
        "Create" => "POST",
        "Update" => "PATCH",
        "Destroy" => "DELETE"
      ).freeze

      def rate_limit(limit:, period:, method: nil, path: nil, by: ->(req) { req.ip })
        method ||= REST_METHODS[name.split("::").last]
        path ||= rest_path
        ::Rack::Attack.throttle("#{name}/#{by.object_id}", limit:, period:) do |req|
          by.call(req) if req.request_method.casecmp?(method.to_s) && req.path == path
        end
      end

      def rest_path
        parts = name.split("::")
        idx = parts.index("Actions") or raise "Cannot derive REST path for #{name}"
        "/" + parts[(idx + 1)..-2].map { INFLECTOR.underscore(_1) }.join("/")
      end
    end
  end
end
