module MarkdownToHTML
  private def markdown_to_html(content : String)
    options = Cmark::Option.flags(ValidateUTF8, Smart, Unsafe)
    Cmark.gfm_to_html(content, options)
  end

  private def markdown_to_html(content : Rosetta::Translation)
    markdown_to_html(content.t)
  end

  private def markdown(text : String | Rosetta::Translation)
    raw markdown_to_html(text)
  end
end
