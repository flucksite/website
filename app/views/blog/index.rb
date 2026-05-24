# frozen_string_literal: true

module FluckWebsite
  module Views
    module Blog
      class Index < FluckWebsite::View
        expose :posts
        expose :current_tag
        expose :tags
        expose :pagination

        expose :page_url do |current_tag:|
          ->(page) { build_page_url(page, current_tag) }
        end

        private

        def build_page_url(page, current_tag)
          uri = URI(routes.path(:blog))
          params = {tag: current_tag}
          params[:page] = page if page.to_i.positive?
          uri.query = URI.encode_www_form(params) unless params.empty?
          uri.to_s
        end
      end
    end
  end
end
