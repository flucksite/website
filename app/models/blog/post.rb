# frozen_string_literal: true

require "marquery"

module Blog
  class Post
    include Marquery::Model

    attribute :tags, type: :array, default: []
    attribute :author

    READING_SPEED_WPM = 220

    def reading_time_minutes
      words = content.to_s.split(/\s+/).length
      [(words.to_f / READING_SPEED_WPM).ceil, 1].max
    end

    def formatted_date = date&.strftime("%d/%m/%Y")

    def iso_date = date&.strftime("%Y-%m-%d")

    def rfc822_date = date&.rfc822
  end
end
