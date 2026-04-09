struct Blog::Post
  include Marquery::Model

  getter tags : Array(String) = [] of String

  def formatted_date : String
    date.to_s("%B %-d, %Y")
  end

  def iso_date : String
    date.to_s("%F")
  end

  def tag_link(tag : String)
    Blog::Index.with(tag: tag)
  end
end
