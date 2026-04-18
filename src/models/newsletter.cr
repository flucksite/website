struct Newsletter::Entry
  include Marquery::Model

  to_html ::Markdown::AnchoredRenderer

  getter sent : Time?

  def formatted_date : String
    date.to_s("%d/%m/%Y")
  end

  def iso_date : String
    date.to_s("%F")
  end

  def sent? : Bool
    !sent.nil?
  end
end
