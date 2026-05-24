# auto_register: false
# frozen_string_literal: true

require "marquery/helpers"
require "otori/hanami"

module FluckWebsite
  module Views
    module Helpers
      include BunBunBundle::Helpers
      include BunBunBundle::ReloadTag

      include Assets
      include Flash
      include Form
      include I18n
      include Page
      include Turbo
      include Urls

      include Marquery::Helpers
      include Otori::Hanami::Helpers
    end
  end
end
