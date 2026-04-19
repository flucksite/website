module TagListable
  def render_tags(tags : Array(String), current_tag : String? = nil, &)
    return if tags.empty?

    ul class: "tag-list", role: "list" do
      tags.each do |tag|
        li do
          link tag,
            to: yield(tag == current_tag ? nil : tag, tag),
            class: "tag",
            data_tag: Wordsmith::Inflector.parameterize(tag),
            aria_current: (tag == current_tag).to_s
        end
      end
    end
  end
end
