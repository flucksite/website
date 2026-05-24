# frozen_string_literal: true

module FluckWebsite
  module Views
    module Blog
      class Show < FluckWebsite::View
        expose :post
        expose :newer
        expose :older

        expose :title, layout: true do |post:|
          post.title
        end

        expose :description, layout: true do |post:|
          post.description
        end
      end
    end
  end
end
