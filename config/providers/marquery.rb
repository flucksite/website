# frozen_string_literal: true

Hanami.app.register_provider :marquery do
  prepare do
    require "marquery"

    Marquery.configure do |config|
      config.data_dir = File.expand_path("data", target.root)
    end

    # Requires all models and queries so they're available in the registry.
    Dir["#{target.root}/app/{models,queries}/**/*.rb"].each { require _1 }
  end

  start do
    # Eagerly loads all marquery data and fixates it in production.
    Marquery.eager_load! if Hanami.env?(:production)
  end
end
