# frozen_string_literal: true

RSpec.describe FluckWebsite::Views::Scopes::TagList, type: :scope do
  let(:scope) do
    build_scope(described_class, locals: {tag_items: %w[values progress], current_tag: current_tag})
  end
  let(:current_tag) { nil }

  describe "#slug_for" do
    it "lowercases and dasherizes a tag" do
      expect(scope.slug_for("Open Source!")).to eq("open-source-")
    end
  end

  describe "#href_for" do
    it "returns ?tag=… for non-current tags" do
      expect(scope.href_for("values")).to eq("/blog?tag=values")
    end

    context "for the currently-filtered tag" do
      let(:current_tag) { "values" }

      it "returns the unfiltered blog path" do
        expect(scope.href_for("values")).to eq("/blog")
      end
    end
  end

  describe "#current?" do
    let(:current_tag) { "values" }

    it { expect(scope.current?("values")).to be(true) }
    it { expect(scope.current?("progress")).to be(false) }
  end
end
