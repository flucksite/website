class Shared::FieldErrors(T) < BaseComponent
  needs attribute : Avram::PermittedAttribute(T)
  needs label_text : String?

  # Customize the markup and styles to match your application
  def render
    unless attribute.valid?
      div class: "error" do
        text "#{label_text_with_fallback} #{attribute.errors.first}"
      end
    end
  end

  def label_text_with_fallback
    label_text || Wordsmith::Inflector.humanize(attribute.name.to_s)
  end
end
