# frozen_string_literal: true

RSpec.describe FluckWebsite::Views::Scopes::Footer, type: :scope do
  subject(:scope) { build_scope(described_class) }

  describe "#info_items" do
    it "lists info and legal entries with route paths" do
      items = scope.info_items
      keys = items.map(&:first)
      expect(keys).to eq(
        %i[blog about waitlist code_of_conduct privacy_policy terms_of_service]
      )
      paths = items.map(&:last)
      expect(paths).to all(start_with("/"))
    end

    it "tags items as :info or :legal" do
      subjects = scope.info_items.map { |_, sub, _| sub }
      expect(subjects.uniq).to contain_exactly(:info, :legal)
    end
  end

  describe "#social_menu" do
    it "exposes every social channel with a URL" do
      expect(scope.social_menu.map(&:first))
        .to contain_exactly(:bluesky, :mastodon, :email, :rss, :codeberg, :github)
      expect(scope.social_menu.map(&:last)).to all(be_a(String))
    end
  end

  describe "#current_year" do
    it "returns the current calendar year" do
      expect(scope.current_year).to eq(Time.now.year)
    end
  end
end
