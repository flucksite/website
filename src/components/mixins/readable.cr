module Readable
  WORDS_PER_MINUTE   = 225
  ROUND_UP_TOLERANCE = 0.2

  def reading_time_in_minutes(content : String) : Int32
    word_count = content.split(/\s+/).count { |word| !word.empty? }
    minutes = ((word_count / WORDS_PER_MINUTE.to_f) - ROUND_UP_TOLERANCE).ceil.to_i
    Math.max(1, minutes)
  end
end
