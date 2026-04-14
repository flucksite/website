module Readable
  WORDS_PER_MINUTE = 250

  def reading_time_in_minutes(content : String) : Int32
    word_count = content.split(/\s+/).reject(&.empty?).size
    minutes = (word_count / WORDS_PER_MINUTE.to_f).round.to_i
    Math.max(1, minutes)
  end
end
