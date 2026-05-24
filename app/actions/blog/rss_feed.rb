# frozen_string_literal: true

module FluckWebsite
  module Actions
    module Blog
      class RssFeed < FluckWebsite::Action
        include Deps["post_query"]

        config.formats.accept :xml

        def handle(_request, response)
          response.render(view, posts: post_query.active.all.first(50))
        end
      end
    end
  end
end
