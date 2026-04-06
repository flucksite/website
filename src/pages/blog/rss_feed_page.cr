require "xml"

class Blog::RssFeedPage
  def initialize(@posts : Array(Blog::Post))
  end

  def to_xml : String
    XML.build(indent: "  ", encoding: "UTF-8") do |xml|
      xml.element("rss", version: "2.0", "xmlns:atom": "http://www.w3.org/2005/Atom") do
        xml.element("channel") do
          channel(xml)
          items(xml)
        end
      end
    end
  end

  private def channel(xml : XML::Builder) : Nil
    blog_url = Blog::Index.url.chomp(".rss")
    xml.element("title") { xml.text "Fluck Blog" }
    xml.element("link") { xml.text blog_url }
    xml.element("description") { xml.text "Updates, progress, new features, and general news from Fluck." }
    xml.element("language") { xml.text "en" }
    xml.element("atom:link", href: "#{blog_url}.rss", rel: "self", type: "application/rss+xml")
  end

  private def items(xml : XML::Builder) : Nil
    @posts.each do |post|
      xml.element("item") do
        xml.element("title") { xml.text post.title }
        xml.element("link") { xml.text post_url(post.slug) }
        xml.element("guid", isPermaLink: "true") { xml.text post_url(post.slug) }
        xml.element("pubDate") { xml.text post.date.to_rfc2822 }
        if description = post.description
          xml.element("description") { xml.text description }
        end
      end
    end
  end

  private def post_url(slug)
    Blog::Show.with(slug: slug).url
  end
end
