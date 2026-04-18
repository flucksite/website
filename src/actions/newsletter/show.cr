class Newsletter::Show < BrowserAction
  get "/newsletter/:slug" do
    html Newsletter::ShowPage,
      newsletter: find_newsletter,
      query: NewsletterQuery.new
  end

  private def find_newsletter
    NewsletterQuery.new.find(params.get(:slug))
  end
end
