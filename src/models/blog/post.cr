struct Blog::Post
  include Marquery::Model

  getter tags : Array(String) = [] of String

  def formatted_date : String
    date.to_s("%d/%m/%Y")
  end

  def iso_date : String
    date.to_s("%F")
  end
end
