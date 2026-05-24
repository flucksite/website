# frozen_string_literal: true

RSpec.describe FluckWebsite::Views::Scopes::SubscriptionForm, type: :scope do
  let(:scope) do
    build_scope(
      described_class,
      locals: {list_tag: list_tag, email_value: "fan@example.com"}
    )
  end
  let(:list_tag) { "newsletter" }

  describe "DOM ids" do
    it "namespaces email and website ids by list_tag" do
      expect(scope.email_dom_id).to eq("newsletter_email")
      expect(scope.website_dom_id).to eq("newsletter_website")
    end
  end

  describe "i18n-derived strings" do
    it "resolves the submit label from the list_tag variant" do
      expect(scope.submit_label).to be_a(String)
      expect(scope.submit_label).not_to be_empty
    end

    it "interpolates the subscribed email into the success message" do
      expect(scope.success_message).to include("fan@example.com")
    end

    it "exposes email and website labels" do
      expect(scope.email_label).to be_a(String)
      expect(scope.website_label).to be_a(String)
    end
  end
end
