# frozen_string_literal: true

RSpec.describe FluckWebsite::MailingLists::Subscribe do
  subject(:operation) { described_class.new(email_octopus: email_octopus) }

  let(:email_octopus) { instance_double(FluckWebsite::EmailOctopus, subscribe: {}) }
  let(:args) do
    {tag: "newsletter", email: " fan@example.com ", website: "", signals_rating: 0.0}
  end

  it "returns Success with the trimmed email on a valid subscription" do
    result = operation.call(**args)
    expect(result).to be_success
    expect(result.value!).to eq(email: "fan@example.com")
  end

  it "forwards tag, fields, and review hint to the EmailOctopus client" do
    operation.call(**args.merge(website: "https://x.test", signals_rating: 0.1))
    expect(email_octopus).to have_received(:subscribe).with(
      email: "fan@example.com",
      tag: {"newsletter" => true, "review" => true},
      fields: {"Website" => "https://x.test", "Signals" => "0.1"}
    )
  end

  it "skips the review tag once the signals rating clears the threshold" do
    operation.call(**args.merge(signals_rating: 0.9))
    expect(email_octopus).to have_received(:subscribe).with(
      hash_including(tag: {"newsletter" => true, "review" => false})
    )
  end

  it "fails with :invalid_tag for an unknown tag" do
    result = operation.call(**args.merge(tag: "bogus"))
    expect(result).to be_failure
    expect(result.failure).to eq(:invalid_tag)
    expect(email_octopus).not_to have_received(:subscribe)
  end

  it "fails with :invalid_email for a malformed email" do
    result = operation.call(**args.merge(email: "no-at-sign"))
    expect(result).to be_failure
    expect(result.failure).to eq(:invalid_email)
    expect(email_octopus).not_to have_received(:subscribe)
  end

  context "when the API raises" do
    let(:email_octopus) { instance_double(FluckWebsite::EmailOctopus) }

    before do
      allow(email_octopus).to receive(:subscribe).and_raise(
        FluckWebsite::EmailOctopus::ApiError, "boom"
      )
    end

    it "fails with :subscription_failed and reports the exception" do
      expect(FluckWebsite::ErrorReporter).to receive(:report).with(
        an_instance_of(FluckWebsite::EmailOctopus::ApiError)
      )
      result = operation.call(**args)
      expect(result).to be_failure
      expect(result.failure).to eq(:subscription_failed)
    end
  end
end
