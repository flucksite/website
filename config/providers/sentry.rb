# frozen_string_literal: true

Hanami.app.register_provider :sentry do
  prepare do
    require "sentry-ruby"
  end

  start do
    dsn = target["settings"].sentry_dsn
    next unless dsn && !dsn.empty?

    Sentry.init do |config|
      config.dsn = dsn
      config.environment = Hanami.env.to_s
      config.breadcrumbs_logger = [:http_logger]
      config.send_default_pii = false
      config.enabled_environments = %w[production staging]
    end
  end
end
