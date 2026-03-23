class Blog::IndexPage < MainLayout
  def content
    h1 "Modify this page at src/pages/blog"

    Blog::PostsQuery.new.all.each do |post|
      h1 post.title
      markdown post.content
    end
  end
end
