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

    # Subscribe a contact to the configured list (upsert via PUT).
    def subscribe(email:, tag:, fields: {})
      raise AuthenticationError, "EMAIL_OCTOPUS_API_KEY missing" if @api_key.nil? || @api_key.empty?
      raise ArgumentError, "list_id missing" if @list_id.nil? || @list_id.empty?

      payload = {
        email_address: email,
        fields: fields,
        tags: tag.is_a?(Hash) ? tag : {tag.to_s => true}
      }

      uri = URI.join(@base_url, "/lists/#{@list_id}/contacts")
      request = Net::HTTP::Put.new(uri.request_uri)
      request["authorization"] = "Bearer #{@api_key}"
      request["content-type"] = "application/json"
      request["accept"] = "application/json"
      request.body = JSON.generate(payload)

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(request)
      end

      handle_response(response)
    end

    private

    def handle_response(response)
      body = response.body.to_s
      data = if body.empty?
               {}
             else
               begin
                 JSON.parse(body)
               rescue StandardError
                 {}
               end
             end

      case response.code.to_i
      when 200..299
        data
      when 401
        raise AuthenticationError, "EmailOctopus rejected the API key"
      else
        raise ApiError, "EmailOctopus #{response.code}: #{data["title"] || body}"
      end
    end
  end
end
