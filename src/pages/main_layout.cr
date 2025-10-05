abstract class MainLayout
  include Lucky::HTMLPage

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

      body hx_boost: true do
        mount Shared::Header
        mount Shared::FlashMessages, context.flash
        content
      end
    end
  end
end
