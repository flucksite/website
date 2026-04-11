class Blog::ShowPage < MainLayout
  include TagListable

  needs post : Blog::Post

  quick_def page_title, post.title
  quick_def page_description, post.description || ""

  def content
    h1 post.title

    div do
      div class: "blog__meta" do
        time post.formatted_date, datetime: post.iso_date
        render_tags(post.tags) do |tag|
          Blog::Index.with(tag: tag)
        end
      end
      div do
        raw post.to_html
      end
    end
  end
end
