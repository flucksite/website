# frozen_string_literal: true

RSpec.shared_context "with stubbed EmailOctopus" do
  let(:email_octopus_stub) do
    WebMock.stub_request(:put, %r{api\.emailoctopus\.com/lists/.*/contacts}).to_return(
      status: 200,
      body: %({"id":"contact-id","email_address":"queued@example.com"}),
      headers: {"content-type" => "application/json"}
    )
  end

  before { email_octopus_stub }
end
