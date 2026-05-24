# auto_register: false
# frozen_string_literal: true

module FluckWebsite
  module Views
    module Scopes
      class Person < Hanami::View::Scope
        def shape
          "circle-0#{index + 1}"
        end

        def image_start
          index.odd? ? "right" : "left"
        end

        def text_start
          index.odd? ? "left" : "right"
        end

        def i18n_key(suffix)
          "about.index_page.people.#{id}.#{suffix}"
        end

        def domain_url
          "https://#{t(i18n_key(:domain))}"
        end

        def image_src(theme)
          bun_asset("images/people/#{id}-#{theme}-theme.png")
        end
      end
    end
  end
end
