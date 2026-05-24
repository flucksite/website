# auto_register: false
# frozen_string_literal: true

module FluckWebsite
  module Views
    module Helpers
      module Flash
        def render_flash(notice: nil, error: nil)
          parts = []
          parts << tag.div(notice, class: "flash", data: {type: "success"}) if notice
          parts << tag.div(error, class: "flash", data: {type: "failure"}) if error
          escape_join(parts)
        end
      end
    end
  end
end
