class HtmlClient < Lucky::BaseHTTPClient
  app AppServer.new

  def initialize
    super
    headers("Accept": "text/html")
  end
end
