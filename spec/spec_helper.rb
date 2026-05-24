# frozen_string_literal: true

require "pathname"
SPEC_ROOT = Pathname(__dir__).realpath.freeze

ENV["HANAMI_ENV"] ||= "test"
ENV["EMAIL_OCTOPUS_API_KEY"] ||= "test-api-key"
ENV["EMAIL_OCTOPUS_LIST_ID"] ||= "test-list-id"

require "hanami/boot"
require "webmock/rspec"
require "otori"

# In tests we don't want otori's timing delay to gate every request.
Otori.configure { |c| c.disable_delay = true }

# Block real HTTP traffic so EmailOctopus requests never escape during tests.
WebMock.disable_net_connect!(allow_localhost: true)

SPEC_ROOT.glob("support/**/*.rb").each { |f| require f }

RSpec.configure do |config|
  # Force-load actions so rate_limit registers throttles before requests.
  config.before(:suite) do
    Hanami.app.keys.grep(/\Aactions\./).each { |k| Hanami.app[k] }
  end

  config.before(:each, type: :request) do
    Rack::Attack.cache.store.instance_variable_get(:@data)&.clear
  end
end
