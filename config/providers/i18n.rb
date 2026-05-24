# frozen_string_literal: true

Hanami.app.register_provider :i18n do
  prepare do
    require "i18n"
  end

  start do
    paths = Dir["#{target.root}/config/locales/**/*.yml"]
    I18n.load_path = (I18n.load_path + paths).uniq
    I18n.available_locales = ([:en] + I18n.available_locales).uniq
    I18n.default_locale ||= :en
    I18n.backend.reload!
  end
end
