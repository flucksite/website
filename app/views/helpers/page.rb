# auto_register: false
# frozen_string_literal: true

module FluckWebsite
  module Views
    module Helpers
      module Page
        def current_theme_arg
          theme = context.request&.cookies&.[]("_fluck_preferred_theme")
          theme ? "'#{theme}'" : "null"
        end
      end
    end
  end
end
