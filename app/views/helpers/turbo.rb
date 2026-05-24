# auto_register: false
# frozen_string_literal: true

module FluckWebsite
  module Views
    module Helpers
      module Turbo
        def turbo_morph_tag
          tag.meta(name: "turbo-refresh-method", content: "morph")
        end

        def turbo_view_transition_tag
          tag.meta(name: "view-transition", content: "same-origin")
        end

        def turbo_frame(**attrs, &)
          tag.send(:"turbo-frame", **attrs, &)
        end
      end
    end
  end
end
