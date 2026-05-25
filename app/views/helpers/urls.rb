# auto_register: false
# frozen_string_literal: true

module FluckWebsite
  module Views
    module Helpers
      # Thin url/route helpers so templates skip `routes.path` boilerplate.
      module Urls
        def url_for(name, **args)
          routes.path(name, **args)
        end

        def current_page?(path)
          context.request.path == path
        end

        def absolute_url(path)
          domain = Hanami.app["settings"].app_domain
          "https://#{domain}#{path}"
        end

        # link_to wrapper that sets aria-current based on the request path.
        def nav_link(*args, **attrs, &block)
          path = block ? args.first : args[1]
          aria = (attrs[:aria] || {}).merge(
            current: current_page?(path) ? "page" : "false"
          )
          link_to(*args, **attrs.merge(aria: aria), &block)
        end
      end
    end
  end
end
