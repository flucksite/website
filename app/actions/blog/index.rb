# frozen_string_literal: true

module FluckWebsite
  module Actions
    module Blog
      class Index < FluckWebsite::Action
        include Deps["post_query", "paginator"]

        def handle(request, response)
          current_tag = request.params[:tag]
          items = post_query.active.with_tag(current_tag).all
          posts, pagination = paginator.call(items, request: request)

          response.render(
            view,
            posts:,
            current_tag:,
            tags: post_query.tags,
            pagination:
          )
        end
      end
    end
  end
end
