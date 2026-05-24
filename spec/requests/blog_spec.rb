# frozen_string_literal: true

RSpec.describe "Blog", type: :request do
  describe "GET /blog" do
    it "renders the blog index with all active posts" do
      get "/blog"
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("The Ethical Move")
      expect(last_response.body).to include("Where we are")
    end

    it "filters posts by tag when ?tag= is set" do
      get "/blog?tag=values"
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("The Ethical Move")
      expect(last_response.body).not_to include("Where we are")
    end

    it "marks the active tag with aria-current and an unfiltered href" do
      get "/blog?tag=values"
      expect(last_response.body).to match(
        %r{<a class="tag"[^>]*data-tag="values"[^>]*aria-current="true"[^>]*href="/blog">}
      )
    end

    context "when the post count exceeds the page limit" do
      before { Pagy::OPTIONS[:limit] = 1 }
      after  { Pagy::OPTIONS[:limit] = 10 }

      it "renders pagy's paginator with a working next-page link" do
        get "/blog"
        expect(last_response.status).to eq(200)
        expect(last_response.body).to include('class="paginator"')
        expect(last_response.body).to include('id="paginator_page_2"')
        expect(last_response.body).to include('aria-current="page"')

        get "/blog?page=2"
        expect(last_response.status).to eq(200)
        expect(last_response.body).to include("The Ethical Move")
        expect(last_response.body).not_to include("Where we are")
      end
    end
  end

  describe "GET /blog/:slug" do
    it "renders an existing post" do
      get "/blog/the-ethical-move"
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("The Ethical Move")
      expect(last_response.body).to include("post__content")
    end

    it "returns 404 for a missing post" do
      get "/blog/never-existed"
      expect(last_response.status).to eq(404)
    end
  end

  describe "GET /blog.rss" do
    it "renders an RSS 2.0 feed with each post" do
      get "/blog.rss"
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("<rss version=\"2.0\"")
      expect(last_response.body).to include("<title>Fluck Blog</title>")
      expect(last_response.body).to include("The Ethical Move")
      expect(last_response.body).to include("<atom:link")
    end
  end
end
