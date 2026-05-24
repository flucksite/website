# frozen_string_literal: true

Hanami.app.register_provider :post_query do
  prepare do
    target.prepare :marquery
  end

  start do
    if Hanami.env?(:production)
      register "post_query", Blog::PostQuery.new
    else
      register "post_query", memoize: false do
        Blog::PostQuery.reload!
        Blog::PostQuery.new
      end
    end
  end
end
