# auto_register: false
# frozen_string_literal: true

module FluckWebsite
  module Views
    module Helpers
      # Layout-wide helpers reading from settings or the current request.
      module Page
        def current_theme_arg
          theme = context.request&.cookies&.[]("_fluck_preferred_theme")
          theme ? "'#{theme}'" : "null"
        end

        def plausible_tag
          settings = Hanami.app["settings"]
          return "" if Hanami.env != :production
          return "" if settings.plausible_domain.nil? || settings.plausible_domain.empty?

          tag.script(
            "",
            defer: true,
            data: {domain: settings.plausible_domain},
            src: settings.plausible_script_src
          )
        end
      end
    end
  end
end
