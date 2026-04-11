class Blog::IndexPage < MainLayout
  include Revealable
  include TagListable

  needs blog : Marquery::Index
  needs posts : Array(Blog::Post)
  needs current_tag : String?
  needs all_tags : Array(String)

  quick_def page_title, blog.title
  quick_def page_description, blog.description || ""

  def content
    render_hero
    render_blog_posts
  end

  private def render_hero
    section class: "hero", data_layout: "blog" do
      div class: "wrapper flow" do
        h1 page_title
        div do
          markdown r(".hero.text").t
        end
        render_tags(all_tags, current_tag) do |tag|
          Blog::Index.with(tag: tag)
        end
      end
    end
  end

  private def render_blog_posts
    section do
      div class: "blog | wrapper" do
        posts.each do |post|
          render_blog_post(post)
        end
      end
    end
  end

  private def render_blog_post(post)
    article class: "blog__post" do
      h2 post.title
      div class: "switcher", data_limit: 3 do
        render_blog_post_meta(post)
        div { }
        render_blog_post_excerpt(post)
      end
    end
  end

  private def render_blog_post_excerpt(post)
    div class: "blog__post-excerpt | flow" do
      para post.description.to_s
      link r("global.links.read_more").t,
        to: Blog::Show.with(slug: post.slug),
        class: "shift"
    end
  end

  private def render_blog_post_meta(post)
    div class: "blog__post-meta | switcher", data_limit: 2 do
      time post.formatted_date, datetime: post.iso_date
      render_tags(post.tags, current_tag) do |tag|
        Blog::Index.with(tag: tag)
      end
    end
  end
end
