class Newsletter::Index < BrowserAction
  include Lucky::Paginator::BackendHelpers

  get "/newsletter" do
    pages, newsletters = paginate_array(all_newsletters, per_page: 20)
    html Newsletter::IndexPage,
      index: NewsletterQuery.index,
      newsletters: newsletters,
      pages: pages
  end

  private def all_newsletters
    NewsletterQuery.new.filter(&.active?).all
  end
end
