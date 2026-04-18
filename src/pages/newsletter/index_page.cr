class Newsletter::IndexPage < MainLayout
  needs index : Marquery::Index
  needs newsletters : Array(Newsletter::Entry)
  needs pages : Lucky::Paginator

  quick_def page_title, index.title
  quick_def page_description, index.description || ""

  def content
    section class: "newsletter | centered flow" do
      render_header
      render_list
    end
  end

  private def render_header
    div class: "newsletter__header | flow" do
      h1 page_title
      if description = index.description
        div do
          markdown description
        end
      end
    end
  end

  private def render_list
    div class: "newsletter__entries | flow" do
      newsletters.each do |newsletter|
        render_entry(newsletter)
      end
    end
    mount Shared::Paginator, pages
  end

  private def render_entry(newsletter)
    article class: "newsletter__entry" do
      link to: Newsletter::Show.with(slug: newsletter.slug) do
        h2 newsletter.title
        time newsletter.formatted_date, datetime: newsletter.iso_date
      end
    end
  end
end
