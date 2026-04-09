class Blog::IndexPage < MainLayout
  include Revealable

  needs index : Marquery::Index
  needs posts : Array(Blog::Post)
  needs tag : String?

  quick_def page_title, index.title
  quick_def page_description, index.description || ""

  def content
    render_hero
    render_posts
  end

  private def render_hero
    section class: "hero" do
      div class: "wrapper flow" do
        h1 page_title
        para tag || "no tag"
        para do
          markdown r(".hero.text").t
        end
      end
    end
  end

  private def render_posts
    section do
      div class: "blog | wrapper" do
        posts.each do |post|
          render_post(post)
        end
      end
    end
  end

  private def render_post(post)
    article **reveal_attr(start: "bottom"), class: "blog__post | reveal" do
      h2 post.title
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
      if description = post.description
        para description
      end
    end
  end
end
