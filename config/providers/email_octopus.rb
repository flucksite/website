# frozen_string_literal: true

Hanami.app.register_provider :email_octopus do
  prepare do
    require "fluck_website/email_octopus"
  end

  start do
    settings = target["settings"]

    register "email_octopus", FluckWebsite::EmailOctopus.new(
      api_key: settings.email_octopus_api_key,
      list_id: settings.email_octopus_list_id
    )
  end
end
