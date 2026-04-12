class Shared::Paginator < BaseComponent
  needs pages : Lucky::Paginator

  def render
    return if pages.one_page?

    nav class: "paginator", aria_labelledby: "paginator_label" do
      span r(".label").t, id: "paginator_label", class: "visually-hidden"
      span r(".prefix").t, id: "paginator_prefix", class: "visually-hidden"
      ul class: "", role: "list" do
        previous_link
        next_link
        page_links
      end
    end
  end

  def page_links
    @pages.series(
      begin: 1,
      left_of_current: 1,
      right_of_current: 1,
      end: 1
    ).each do |item|
      li do
        render_page_link(item)
      end
    end
  end

  def render_page_link(page : Lucky::Paginator::Page)
    a page.number, **page_link_args(page)
  end

  def render_page_link(page : Lucky::Paginator::CurrentPage)
    a page.number, **page_link_args(page), aria_current: true
  end

  def render_page_link(gap : Lucky::Paginator::Gap)
    span "..."
  end

  {% for key, label in {previous: "«", next: "»"} %}
    {% key = key.id %}
    def {{ key }}_link
      li do
        span r(".{{ key }}").t, id: "paginator_{{ key }}", class: "visually-hidden"
        if {{ key }}_path = @pages.path_to_{{ key }}
          a {{ label }}, href: {{ key }}_path, aria_labelledby: "paginator_{{ key }}"
        else
          span {{ label }}
        end
      end
    end
  {% end %}

  private def page_link_args(page)
    {
      href:            page.path,
      id:              "paginator_page_#{page.number}",
      aria_labelledby: "paginator_prefix paginator_page_#{page.number}",
    }
  end
end
