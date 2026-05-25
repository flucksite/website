# frozen_string_literal: true

require "json"
require "net/http"
require "uri"

module FluckWebsite
  # Minimal EmailOctopus client; only the upsert-contact endpoint is used.
  class EmailOctopus
    API_BASE = "https://api.emailoctopus.com"

    Error = Class.new(StandardError)
    AuthenticationError = Class.new(Error)
    ApiError = Class.new(Error)

    def initialize(api_key:, list_id:, base_url: API_BASE)
      @api_key = api_key
      @list_id = list_id
      @base_url = base_url
    end

    def subscribe(email:, tag:, fields: {})
      raise AuthenticationError, "EMAIL_OCTOPUS_API_KEY missing" if @api_key.nil? || @api_key.empty?
      raise ArgumentError, "list_id missing" if @list_id.nil? || @list_id.empty?

      uri = URI.join(@base_url, "/lists/#{@list_id}/contacts")
      use_ssl = uri.scheme == "https"
      payload = {
        email_address: email,
        fields:,
        tags: tag.is_a?(Hash) ? tag : {tag.to_s => true}
      }

      response = Net::HTTP.start(uri.host, uri.port, use_ssl:) do |http|
        http.request(build_request(uri.request_uri, payload))
      end

      handle_response(response)
    end

    private

    def build_request(uri, payload)
      Net::HTTP::Put.new(uri).tap do |request|
        request["authorization"] = "Bearer #{@api_key}"
        request["content-type"] = "application/json"
        request["accept"] = "application/json"
        request.body = JSON.generate(payload)
      end
    end

    def handle_response(response)
      body = response.body.to_s
      data = parse_response_body(body)

      case response.code.to_i
      when 200..299
        data
      when 401
        raise AuthenticationError, "EmailOctopus rejected the API key"
      else
        raise ApiError, "EmailOctopus #{response.code}: #{data["title"] || body}"
      end
    end

    def parse_response_body(body)
      return {} if body.empty?

      JSON.parse(body)
    rescue StandardError
      {}
    end
  end
end
