class Newsletter::ShowPage < MainLayout
  include Readable

  needs newsletter : Newsletter::Entry
  needs query : NewsletterQuery

  quick_def page_title, newsletter.title
  quick_def page_description, newsletter.description || ""

  def content
    article class: "post | centered flow" do
      render_header
      render_content
      render_footer
    end
  end

  private def render_header
    div class: "post__header | flow" do
      h1 newsletter.title
      time newsletter.formatted_date,
        datetime: newsletter.iso_date,
        class: "post__date"
      span class: "post__reading-time" do
        text " — "
        text r(".reading_time").t(count: reading_time_in_minutes(newsletter.content))
      end
    end
  end

  private def render_content
    div class: "prose flow" do
      raw newsletter.to_html
    end
  end

  private def render_footer
    render_pagination
  end

  private def render_pagination
    nav class: "post__pagination | switcher",
      data_limit: 2,
      aria_labelledby: "pagination_label" do
      span r(".pagination").t, id: "pagination_label", class: "visually-hidden"
      ul class: "", role: "list" do
        li do
          if newer = query.previous(newsletter)
            link r(".newer").t, to: Newsletter::Show.with(slug: newer.slug)
          else
            link r(".back_to_index").t, to: Newsletter::Index
          end
        end
        li do
          if older = query.next(newsletter)
            link r(".older").t, to: Newsletter::Show.with(slug: older.slug)
          else
            nbsp
          end
        end
      end
    end
  end
end
