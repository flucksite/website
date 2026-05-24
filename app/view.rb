# auto_register: false
# frozen_string_literal: true

require "hanami/view"
require "fluck_website/views/i18n_scope"

module FluckWebsite
  class View < Hanami::View
    include Views::I18nScope

    # Partials under `templates/components/` are callable by bare name globally.
    config.paths = [
      *config.paths,
      Hanami.app.root.join("app/templates/components").to_s
    ]

    private def routes = Hanami.app["routes"]
  end
end
