class Blog::PostsQuery
  macro load!
    {%
      posts = run("../../run_macros/posts_parser")

      unless posts.starts_with?('[')
        raise "Failed to parse blog posts: " + posts
      end
    %}

    POSTS = Array(Blog::Post).from_json({{ posts.stringify }})
  end

  def initialize
    @posts = POSTS
  end

  def all
    @posts.sort_by(&.date).reverse
  end
end
