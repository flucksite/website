# frozen_string_literal: true

require "fluck_website/actions/i18n_scope"

RSpec.describe FluckWebsite::Actions::I18nScope do
  describe ".scope_for" do
    it "derives a dotted, snake_cased scope from an Actions class name" do
      klass = Class.new
      stub_const("FluckWebsite::Actions::MailingLists::Create", klass)
      expect(described_class.scope_for(klass)).to eq("mailing_lists.create")
    end

    it "handles single-segment scopes" do
      klass = Class.new
      stub_const("FluckWebsite::Actions::Home::Index", klass)
      expect(described_class.scope_for(klass)).to eq("home.index")
    end

    it "returns an empty string when the class isn't under Actions" do
      klass = Class.new
      stub_const("FluckWebsite::Other", klass)
      expect(described_class.scope_for(klass)).to eq("")
    end
  end
end
