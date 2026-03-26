require "json"
require "yaml"
require "wordsmith"

# Marquery
begin
  location = Time::Location.load("Europe/Madrid")
  time_format = "%Y%m%d"
  date_regex = /^(?<date>\d{8})_(?<name>[^.]+)/
  content_regex = /\A(?:-{3}\n(?<frontmatter>.*?)\n-{3}\n)?(?<body>.*)\z/m

  posts = Dir.glob("./data/posts/*.md").map do |filename|
    # Try to match date and name from filename or fail
    filename_match = File.basename(filename).match(date_regex) ||
                     raise(%(Invalid filename: "#{filename}"))

    # Try to match frontmatter and content or fail.
    content_match = File.read(filename).match(content_regex) ||
                    raise(%(Unable to parse file content))

    # Build base post
    post = {} of String => Bool | Float64 | Int32 | String | Time
    post["title"] = Wordsmith::Inflector.humanize(filename_match["name"].to_s)
    post["date"] = Time.parse(filename_match["date"], time_format, location)
    post["content"] = content_match["body"].strip

    # Parse frontmatter
    if frontmatter = content_match["frontmatter"]?
      YAML.parse(frontmatter).as_h.each do |key, value|
        post[key.as_s] =
          value.as_bool? ||
            value.as_i? ||
            value.as_f? ||
            value.as_s? ||
            value.as_time? ||
            raise %(Unknown frontmatter data type "#{value.class}")
      end
    end

    post
  end

  puts posts.to_json
rescue ex
  puts ex
end
