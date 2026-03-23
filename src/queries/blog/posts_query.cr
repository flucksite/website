class Blog::PostsQuery
  macro load!
    {%
      posts = run("../../run_macros/posts_parser")

      unless posts.starts_with?('[')
        raise posts.stringify
      end
    %}

    POSTS = Array(Blog::Post).from_json(%({{ posts }}))
  end

  def initialize
    @posts = POSTS
  end

  def all
    @posts.sort_by(&.date).reverse
  end
end
