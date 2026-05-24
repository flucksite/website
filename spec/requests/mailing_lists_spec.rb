# frozen_string_literal: true

RSpec.describe "Mailing lists", type: :request do
  include_context "with stubbed EmailOctopus"

  describe "POST /mailing_lists" do
    let(:params) do
      {
        "subscription" => {
          "tag" => "newsletter",
          "email" => "fan@example.com",
          "name" => "",
          "website" => ""
        }
      }
    end

    it "subscribes the contact and renders the success message" do
      post "/mailing_lists", params
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("subscription-form__success")
      expect(last_response.body).to include("fan@example.com")
      expect(email_octopus_stub).to have_been_requested
    end

    it "halts with 204 when the honeypot field is filled" do
      tripped = params.deep_dup
      tripped["subscription"]["name"] = "spam-bot"
      post "/mailing_lists", tripped
      expect(last_response.status).to eq(204)
      expect(email_octopus_stub).not_to have_been_requested
    end

    it "re-renders with field errors for an invalid email" do
      bad = params.deep_dup
      bad["subscription"]["email"] = "not-an-email"
      post "/mailing_lists", bad
      expect(last_response.status).to eq(422)
      expect(last_response.body).to include("field-errors")
      expect(email_octopus_stub).not_to have_been_requested
    end

    it "throttles requests above 5 per minute from the same IP" do
      # one fresh session = one IP for rack-attack's tracker
      6.times.map do |i|
        p = params.deep_dup
        p["subscription"]["email"] = "rate#{i}@x.com"
        post "/mailing_lists", p
      end
      expect(last_response.status).to eq(429)
    end
  end
end
