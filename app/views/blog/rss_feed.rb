# frozen_string_literal: true

module FluckWebsite
  module Views
    module Blog
      class RssFeed < FluckWebsite::View
        config.layout = false
        config.default_format = :xml

        expose :posts
      end
    end
  end
end
