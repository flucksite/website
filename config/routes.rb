# frozen_string_literal: true

module FluckWebsite
  class Routes < Hanami::Routes
    root to: "home.index"

    get "/about",            to: "about.index",            as: :about
    get "/waitlist",         to: "waitlist.index",         as: :waitlist
    get "/privacy_policy",   to: "privacy_policy.index",   as: :privacy_policy
    get "/terms_of_service", to: "terms_of_service.index", as: :terms_of_service
    get "/code_of_conduct",  to: "code_of_conduct.index",  as: :code_of_conduct

    get  "/blog",       to: "blog.index",    as: :blog
    get  "/blog.rss",   to: "blog.rss_feed", as: :blog_rss
    get  "/blog/:slug", to: "blog.show",     as: :blog_post

    post "/mailing_lists", to: "mailing_lists.create", as: :mailing_lists

    get "/ops/health", to: "ops.health", as: :ops_health
  end
end
