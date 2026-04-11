@[Marquery::Dir("data")]
class Blog::PostQuery
  include Marquery::Query

  model Blog::Post

  def tags
    filter(&.active?).all.map(&.tags).flatten.uniq.sort
  end
end
