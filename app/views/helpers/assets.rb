# auto_register: false
# frozen_string_literal: true

require "fluck_website/inline_svg"

module FluckWebsite
  module Views
    module Helpers
      module Assets
        def inline_svg(path, **attrs)
          raw(FluckWebsite::InlineSvg.render(path, **attrs))
        end
      end
    end
  end
end
