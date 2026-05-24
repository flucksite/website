# frozen_string_literal: true

require "fluck_website/email_octopus"

RSpec.describe FluckWebsite::EmailOctopus do
  let(:client) { described_class.new(api_key: "key", list_id: "list-id") }

  describe "#subscribe" do
    it "PUTs the contact payload to the EmailOctopus API" do
      stub = WebMock.stub_request(
        :put, "https://api.emailoctopus.com/lists/list-id/contacts"
      ).with(
        headers: {"authorization" => "Bearer key", "content-type" => "application/json"},
        body: hash_including("email_address" => "x@y.com", "tags" => {"newsletter" => true})
      ).to_return(status: 200, body: %({"id":"abc"}))

      result = client.subscribe(email: "x@y.com", tag: "newsletter")
      expect(result).to eq("id" => "abc")
      expect(stub).to have_been_requested
    end

    it "accepts a hash of tags for multi-tag subscriptions" do
      WebMock.stub_request(
        :put, "https://api.emailoctopus.com/lists/list-id/contacts"
      ).with(
        body: hash_including("tags" => {"newsletter" => true, "review" => true})
      ).to_return(status: 200, body: "{}")

      client.subscribe(email: "x@y.com", tag: {"newsletter" => true, "review" => true})
    end

    it "raises AuthenticationError when the API rejects the key" do
      WebMock.stub_request(:put, /api\.emailoctopus\.com/).to_return(status: 401, body: "{}")
      expect { client.subscribe(email: "x@y.com", tag: "newsletter") }
        .to raise_error(FluckWebsite::EmailOctopus::AuthenticationError)
    end

    it "raises ApiError for other failure responses" do
      WebMock.stub_request(:put, /api\.emailoctopus\.com/).to_return(
        status: 422, body: %({"title":"Validation error"})
      )
      expect { client.subscribe(email: "x@y.com", tag: "newsletter") }
        .to raise_error(FluckWebsite::EmailOctopus::ApiError, /Validation error/)
    end

    it "raises AuthenticationError early when api_key is missing" do
      empty = described_class.new(api_key: nil, list_id: "list-id")
      expect { empty.subscribe(email: "x@y.com", tag: "newsletter") }
        .to raise_error(FluckWebsite::EmailOctopus::AuthenticationError, /missing/)
    end
  end
end
