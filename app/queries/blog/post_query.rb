# frozen_string_literal: true

require "marquery"
require_relative "../../models/blog/post"

module Blog
  class PostQuery
    include Marquery::Query

    dir "blog_post"
    model Blog::Post
    order_by :date, :desc

    def active = filter(&:active?)

    def tags = active.flat_map(&:tags).uniq.sort

    def with_tag(tag)
      return self if tag.nil? || tag.empty?

      filter { _1.tags.include?(tag) }
    end
  end
end
