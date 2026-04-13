class Blog::ShowPage < MainLayout
  include TagListable
  include Readable

  needs post : Blog::Post
  needs query : Blog::PostQuery

  quick_def page_title, post.title
  quick_def page_description, post.description || ""

  def content
    article class: "post | centered flow" do
      render_header
      render_content
      render_footer
    end
  end

  private def render_header
    div class: "post__header" do
      h1 post.title
      div class: "post__meta | switcher", data_limit: 2 do
        div do
          time post.formatted_date, datetime: post.iso_date, class: "post__date"
          span class: "post__reading-time" do
            text " — "
            text r(".reading_time").t(count: reading_time_in_minutes(post.content))
          end
        end
        para class: "post__author" do
          if author = post.author
            text r(".written_by").t
            text " "
            link author, to: About::Index.with(anchor: author.downcase)
          else
            nbsp
          end
        end
      end
    end
  end

  private def render_content
    div class: "post__content | prose flow" do
      raw post.to_html
    end
  end

  private def render_footer
    div class: "post__footer | flow" do
      div class: "post__tags" do
        span r(".posted_in").t
        render_tags(post.tags) do |tag|
          Blog::Index.with(tag: tag)
        end
      end
      render_pagination
    end
  end

  private def render_pagination
    nav class: "post__pagination | switcher",
      data_limit: 2,
      aria_labelledby: "pagination_label" do
      span r(".post_pagination").t, id: "pagination_label", class: "visually-hidden"
      ul class: "", role: "list" do
        li do
          if next_post = query.next(post)
            link r("global.links.newer").t, to: Blog::Show.with(slug: next_post.slug)
          else
            link r("global.links.back_to_blog").t, to: Blog::Index
          end
        end
        li do
          if previous_post = query.previous(post)
            link r("global.links.older").t, to: Blog::Show.with(slug: previous_post.slug)
          else
            nbsp
          end
        end
      end
    end
  end
end
