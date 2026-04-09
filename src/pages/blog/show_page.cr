class Blog::ShowPage < MainLayout
  needs post : Blog::Post

  quick_def page_title, post.title
  quick_def page_description, post.description || ""

  def content
    h1 post.title

    div do
      div class: "blog__meta" do
        time post.formatted_date, datetime: post.iso_date
        unless post.tags.empty?
          ul class: "blog__tags" do
            post.tags.each do |tag|
              li { link tag, to: post.tag_link(tag) }
            end
          end
        end
      end
      div do
        raw post.to_html
      end
    end
  end
end
