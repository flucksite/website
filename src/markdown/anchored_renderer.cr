require "cmark"
require "wordsmith"

module Markdown
  struct AnchoredRenderer
    include Marquery::MarkdownToHtml

    OPTIONS    = Cmark::Option.flags(ValidateUTF8, Smart, Unsafe)
    EXTENSIONS = Cmark::Extension::All

    def markdown_to_html(content : String) : String
      document = Cmark.parse_gfm(content.strip, OPTIONS)
      heading_nodes(document).each do |heading|
        heading.replace_with(build_anchored_heading(heading))
      end
      document.render_html(OPTIONS, EXTENSIONS)
    end

    private def heading_nodes(document : Cmark::Node) : Array(Cmark::Node)
      Cmark::EventIterator.new(document)
        .modifiable_node_iterator
        .select(&.type.heading?)
        .to_a
    end

    private def build_anchored_heading(heading : Cmark::Node) : Cmark::Node
      level = heading.heading_level
      text = heading.render_plaintext(OPTIONS).strip
      heading = Shared::HeadingWithAnchor.new(level: level, text: text)
      Cmark::NodeMaker.html_block(heading.render_to_string)
    end
  end
end
