class AppClient < Lucky::BaseHTTPClient
  app AppServer.new
end
