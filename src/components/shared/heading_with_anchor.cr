class Shared::HeadingWithAnchor < BaseComponent
  needs level : Int32
  needs text : String

  def render
    slug = Wordsmith::Inflector.parameterize(text)
    tag("h#{level}", id: slug) do
      a "#", href: "##{slug}", class: "heading-anchor"
      text HTML.escape(text)
    end
  end
end
