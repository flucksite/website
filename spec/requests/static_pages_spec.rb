# frozen_string_literal: true

RSpec.describe "Static pages", type: :request do
  describe "GET /" do
    it "renders the home page" do
      get "/"
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Your site, your rules")
      expect(last_response.body).to include("subscription_form_newsletter")
    end
  end

  describe "GET /about" do
    it "renders the about page" do
      get "/about"
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("About us")
      expect(last_response.body).to include("Mick")
      expect(last_response.body).to include("Wout")
    end
  end

  describe "GET /waitlist" do
    it "renders the waitlist page with subscription form" do
      get "/waitlist"
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Join the waitlist")
      expect(last_response.body).to include("subscription_form_waitlist")
    end
  end

  describe "GET /privacy_policy" do
    it "renders the privacy policy" do
      get "/privacy_policy"
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Privacy")
    end
  end

  describe "GET /terms_of_service" do
    it "renders the terms of service" do
      get "/terms_of_service"
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Terms")
    end
  end

  describe "GET /code_of_conduct" do
    it "renders the code of conduct" do
      get "/code_of_conduct"
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Code of conduct")
    end
  end

  describe "GET /ops/health" do
    it "returns ok plaintext" do
      get "/ops/health"
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq("ok")
    end
  end

  describe "GET an unknown path" do
    it "returns 404" do
      get "/totally-unknown"
      expect(last_response.status).to eq(404)
    end
  end
end
