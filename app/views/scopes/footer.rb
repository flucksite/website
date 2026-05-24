# auto_register: false
# frozen_string_literal: true

module FluckWebsite
  module Views
    module Scopes
      class Footer < Hanami::View::Scope
        def info_items
          [
            [:blog,             :info,  routes.path(:blog)],
            [:about,            :info,  routes.path(:about)],
            [:waitlist,         :info,  routes.path(:waitlist)],
            [:code_of_conduct,  :legal, routes.path(:code_of_conduct)],
            [:privacy_policy,   :legal, routes.path(:privacy_policy)],
            [:terms_of_service, :legal, routes.path(:terms_of_service)]
          ]
        end

        def social_menu
          [
            [:bluesky,  "https://bsky.app/profile/fluck.site/"],
            [:mastodon, "https://indieweb.social/@fluck/"],
            [:email,    "mailto:info@fluck.site"],
            [:rss,      routes.path(:blog_rss)],
            [:codeberg, "https://codeberg.org/fluck/"],
            [:github,   "https://github.com/flucksite/"]
          ]
        end

        def current_year = Time.now.year
      end
    end
  end
end
