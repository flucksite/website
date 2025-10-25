require "sitemapper"

APP_DOMAIN = ENV.fetch("APP_DOMAIN", "fluck.site")

Sitemapper.configure do |c|
  c.host = "https://#{APP_DOMAIN}"
  c.use_index = false
  c.compress = false
end

class GenerateSitemap < LuckyTask::Task
  summary "Generate the sitemap.xml for #{APP_DOMAIN}"

  def call
    sitemaps = Sitemapper.build do |builder|
      builder.add(Home::Index.path, changefreq: "yearly", priority: 0.9)
      builder.add(About::Index.path, changefreq: "yearly", priority: 0.7)
      builder.add(Waitlist::Index.path, changefreq: "yearly", priority: 0.6)
      builder.add(CodeOfConduct::Index.path, changefreq: "yearly", priority: 0.5)
    end

    Sitemapper.store(sitemaps, "./public")
  end
end
