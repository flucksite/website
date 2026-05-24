# frozen_string_literal: true

module FluckWebsite
  module Actions
    module Blog
      class Show < FluckWebsite::Action
        include Deps["post_query"]

        def handle(request, response)
          query = post_query.active
          post = query.find_by_slug(request.params[:slug]) or halt 404

          response.render(
            view,
            post:,
            newer: query.previous(post),
            older: query.next(post)
          )
        end
      end
    end
  end
end
