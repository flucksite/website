abstract class MainLayout
  include Lucky::HTMLPage
  include MarkdownToHTML

  abstract def content
  abstract def page_title

  # The default page title. It is passed to `Shared::LayoutHead`.
  #
  # Add a `page_title` method to pages to override it. You can also remove
  # This method so every page is required to have its own page title.
  def page_title
    r(".page_title").t
  end

  def page_description
    r(".page_description").t
  end

  def render
    html_doctype

    html lang: Rosetta.locale do
      mount Shared::LayoutHead,
        page_title: page_title,
        page_description: page_description

      body data_bg: current_bg do
        skip_link
        inline_svg("clip-path-shapes-03.svg")
        mount Shared::Header
        mount Shared::FlashMessages, context.flash
        main id: "main_content" do
          content
        end
        mount Shared::Footer
      end
    end
  end

  private def skip_link
    a r("global.buttons.skip_link").t, href: "#main_content", id: "skip_link"
  end

  private def current_bg
    case {{@type.stringify}}
    when "Home::IndexPage"     then "home"
    when "About::IndexPage"    then "about"
    when "Waitlist::IndexPage" then "waitlist"
    else                            "default"
    end
  end
end
