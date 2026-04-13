struct Blog::Post
  include Marquery::Model

  to_html ::Markdown::AnchoredRenderer

  getter tags : Array(String) = [] of String
  getter author : String?

  def formatted_date : String
    date.to_s("%d/%m/%Y")
  end

  def iso_date : String
    date.to_s("%F")
  end
end
