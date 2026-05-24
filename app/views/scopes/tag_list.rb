# auto_register: false
# frozen_string_literal: true

module FluckWebsite
  module Views
    module Scopes
      class TagList < Hanami::View::Scope
        def slug_for(tag)
          tag.downcase.gsub(/[^a-z0-9-]+/, "-")
        end

        def href_for(tag)
          current?(tag) ? routes.path(:blog) : "#{routes.path(:blog)}?tag=#{tag}"
        end

        # current_tag and tag may be Hanami::View::Part wrappers; compare strings.
        def current?(tag)
          current_tag.to_s == tag.to_s
        end
      end
    end
  end
end
