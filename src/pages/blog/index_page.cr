class Blog::IndexPage < MainLayout
  include Revealable

  def content
    render_hero
    render_posts
  end

  private def render_hero
    section class: "hero" do
      div class: "wrapper flow" do
        h1 r(".hero.title").t
        para do
          markdown r(".hero.text").t
        end
      end
    end
  end

  private def render_posts
    section do
      div class: "wrapper flow" do
        Blog::PostQuery.new.all.each do |post|
          article **reveal_attr(start: "right"), class: "card | flow reveal" do
            h2 post.title
            if description = post.description
              para description
            end
            markdown post.content
          end
        end
      end
    end
  end
end
