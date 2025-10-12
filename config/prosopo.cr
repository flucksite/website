Prosopo.configure do |settings|
  settings.site_key = ENV.fetch("PROSOPO_SITE_KEY")
  settings.secret_key = ENV.fetch("PROSOPO_SECRET_KEY")
end
