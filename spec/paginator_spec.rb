# frozen_string_literal: true

RSpec.describe FluckWebsite::Paginator do
  subject(:paginator) { described_class.new }

  let(:items) { (1..25).to_a }
  let(:page) { 1 }
  let(:request) do
    Rack::Request.new(Rack::MockRequest.env_for("/blog?page=#{page}"))
  end

  before { Pagy::OPTIONS[:limit] = 5 }
  after  { Pagy::OPTIONS[:limit] = 10 }

  it "paginates an array and returns the current page slice" do
    paged, _pagination = paginator.call(items, request: request)
    expect(paged).to eq([1, 2, 3, 4, 5])
  end

  it "wraps pagy state in a Pagination data struct" do
    _paged, pagination = paginator.call(items, request: request)
    expect(pagination).to be_a(FluckWebsite::Paginator::Pagination)
    expect(pagination.current_page).to eq(1)
    expect(pagination.pages).to eq(5)
    expect(pagination.previous_page).to be_nil
    expect(pagination.next_page).to eq(2)
  end

  it "marks the current page in the series" do
    _paged, pagination = paginator.call(items, request: request)
    current = pagination.series.find { |item| item[:current] }
    expect(current).to eq(number: 1, current: true, gap: false)
  end

  context "with a middle page" do
    let(:page) { 3 }
    let(:items) { (1..100).to_a }

    it "represents pagy's gap entries with {gap: true}" do
      _paged, pagination = paginator.call(items, request: request)
      expect(pagination.series).to include(gap: true)
    end
  end
end
