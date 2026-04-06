class Blog::ShowPage < MainLayout
  def page_title
    "Placeholder"
  end

  def page_description
    "This is a placeholder"
  end

  def content
    h1 "Modify this page at src/pages/blog"
  end
end
