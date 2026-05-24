# auto_register: false
# frozen_string_literal: true

module FluckWebsite
  module Views
    class Context < Hanami::View::Context
      def current_path
        request&.path
      end

      def session
        request&.session
      end

      def routes
        Hanami.app["routes"]
      end
    end
  end
end
