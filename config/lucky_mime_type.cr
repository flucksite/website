# :nodoc:
class Lucky::MimeType
  # Extract format from URL path (e.g., "/reports/123.csv" -> Format::Csv)
  def self.extract_format_from_path(path : String) : Lucky::Format | Lucky::FormatRegistry::CustomFormat | Nil
    # Only match extensions in the path portion (before any query string)
    # if match = path.match(/^[^?]*\.([a-zA-Z0-9]+)(?:\?|$)/)
    if match = path.match(/\.([a-zA-Z0-9]+)(?:\?.*)?$/)
      extension = match[1]
      Lucky::FormatRegistry.from_extension(extension)
    end
  end
end
