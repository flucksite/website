# frozen_string_literal: true

module FluckWebsite
  module Actions
    module Ops
      class Health < FluckWebsite::Action
        config.formats.accept :txt

        def handle(_request, response)
          response.body = "ok"
        end
      end
    end
  end
end
