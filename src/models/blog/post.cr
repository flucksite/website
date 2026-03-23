require "json"

struct Blog::Post
  include JSON::Serializable

  getter title : String
  getter description : String?
  getter content : String
  getter date : Time
  getter active : Bool = false
end
