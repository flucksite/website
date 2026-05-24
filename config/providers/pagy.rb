# frozen_string_literal: true

Hanami.app.register_provider :pagy do
  prepare do
    require "pagy"

    Pagy::OPTIONS[:limit] = 10
  end
end
