# frozen_string_literal: true

require_relative "../../../app/queries/blog/post_query"

RSpec.describe Blog::PostQuery do
  subject(:query) { described_class.new }

  it "loads posts from data/blog_post" do
    expect(query.all.size).to be >= 2
  end

  it "orders posts by descending date" do
    dates = query.all.map(&:date)
    expect(dates).to eq(dates.sort.reverse)
  end

  it "exposes the union of tags from active posts" do
    expect(query.tags).to include("values", "progress")
  end

  describe "#with_tag" do
    it "narrows the query to posts with the given tag" do
      filtered = query.active.with_tag("values").all
      expect(filtered.map(&:tags).flatten).to all(include("values"))
    end

    it "returns the whole query when tag is nil or empty" do
      expect(query.with_tag(nil).all).to eq(query.all)
      expect(query.with_tag("").all).to eq(query.all)
    end
  end

  describe "#previous and #next" do
    it "navigates between adjacent entries" do
      posts = query.all
      skip "needs at least 2 posts" if posts.size < 2
      expect(query.previous(posts.last)).to eq(posts[-2])
      expect(query.next(posts.first)).to eq(posts[1])
    end

    it "returns nil at the boundaries" do
      posts = query.all
      expect(query.previous(posts.first)).to be_nil
      expect(query.next(posts.last)).to be_nil
    end
  end
end

RSpec.describe Blog::Post do
  let(:post) do
    Blog::PostQuery.new.find_by_slug("the-ethical-move")
  end

  it "exposes title, slug, date, author, tags" do
    expect(post.title).to eq("The Ethical Move")
    expect(post.slug).to eq("the-ethical-move")
    expect(post.author).to eq("Wout")
    expect(post.tags).to include("values")
  end

  it "computes reading_time_minutes from the body" do
    expect(post.reading_time_minutes).to be >= 1
  end

  it "formats dates consistently" do
    expect(post.iso_date).to match(/\A\d{4}-\d{2}-\d{2}\z/)
    expect(post.formatted_date).to match(%r{\A\d{2}/\d{2}/\d{4}\z})
  end

  it "renders to HTML via Marquery" do
    expect(post.to_html).to include("<p>")
  end
end
