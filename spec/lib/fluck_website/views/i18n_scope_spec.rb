# frozen_string_literal: true

require "fluck_website/views/i18n_scope"

RSpec.describe FluckWebsite::Views::I18nScope do
  describe ".scope_string_for" do
    it "suffixes the leaf segment with _page" do
      klass = Class.new
      stub_const("FluckWebsite::Views::Blog::Show", klass)
      expect(described_class.scope_string_for(klass)).to eq("blog.show_page")
    end

    it "snake_cases nested namespace segments" do
      klass = Class.new
      stub_const("FluckWebsite::Views::MailingLists::Create", klass)
      expect(described_class.scope_string_for(klass)).to eq("mailing_lists.create_page")
    end

    it "returns an empty string when the class isn't under Views" do
      klass = Class.new
      stub_const("FluckWebsite::Other", klass)
      expect(described_class.scope_string_for(klass)).to eq("")
    end
  end

  describe ".page_key_for" do
    it "derives a slash-joined namespace from the View class" do
      klass = Class.new
      stub_const("FluckWebsite::Views::Blog::Show", klass)
      expect(described_class.page_key_for(klass)).to eq("blog")
    end

    it "returns an empty string for a top-level view" do
      klass = Class.new
      stub_const("FluckWebsite::Views::Index", klass)
      expect(described_class.page_key_for(klass)).to eq("")
    end
  end
end
