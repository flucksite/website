# frozen_string_literal: true

RSpec.describe FluckWebsite::Views::Scopes::Person, type: :scope do
  subject(:scope) { build_scope(described_class, locals: {id: "mick", index: index}) }
  let(:index) { 0 }

  describe "#shape" do
    it "uses circle-0(index+1) per bio" do
      expect(scope.shape).to eq("circle-01")
      expect(build_scope(described_class, locals: {id: "wout", index: 1}).shape).to eq("circle-02")
    end
  end

  describe "reveal directions" do
    context "for an even index" do
      it "anchors image left and text right" do
        expect(scope.image_start).to eq("left")
        expect(scope.text_start).to eq("right")
      end
    end

    context "for an odd index" do
      let(:index) { 1 }

      it "anchors image right and text left" do
        expect(scope.image_start).to eq("right")
        expect(scope.text_start).to eq("left")
      end
    end
  end

  describe "#i18n_key" do
    it "namespaces under the about page" do
      expect(scope.i18n_key(:title)).to eq("about.show_page.people.mick.title")
    end
  end

  describe "#domain_url" do
    it "prefixes the locale-provided domain with https://" do
      expect(scope.domain_url).to start_with("https://")
      expect(scope.domain_url).to end_with(I18n.t("about.show_page.people.mick.domain"))
    end
  end
end
