# frozen_string_literal: true

module FluckWebsite
  class Routes < Hanami::Routes
    root to: "home.index"

    resource :about,            only: [:show]
    resource :waitlist,         only: [:show]
    resource :privacy_policy,   only: [:show]
    resource :terms_of_service, only: [:show]
    resource :code_of_conduct,  only: [:show]

    get  "/blog",       to: "blog.index",    as: :blog
    get  "/blog.rss",   to: "blog.rss_feed", as: :blog_rss
    get  "/blog/:slug", to: "blog.show",     as: :blog_post

    resources :mailing_lists, only: [:create]

    get "/ops/health", to: "ops.health", as: :ops_health
  end
end
