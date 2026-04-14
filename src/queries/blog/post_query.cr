@[Marquery::Dir("data")]
class Blog::PostQuery
  include Marquery::Query

  model Blog::Post

  def tags
    filter(&.active?).all.flat_map(&.tags).uniq!.sort!
  end
end
