class Shared::FieldErrors(T) < BaseComponent
  needs attribute : Avram::PermittedAttribute(T)

  # Customize the markup and styles to match your application
  def render
    return if attribute.valid?

    div class: "field__error" do
      text "#{label_text} #{attribute.errors.first}"
    end
  end

  def label_text
    Rosetta.find(
      "avram.attribute_variants",
      Wordsmith::Inflector.humanize(attribute.name.to_s)
    ).t(variant: attribute.name.to_s)
  end
end
