class Shared::Footer < BaseComponent
  SOCIAL_MENU = {
    bluesky:   "https://bsky.app/profile/fluck.site/",
    mastodon:  "https://indieweb.social/@fluck/",
    discord:   "https://discord.gg/aycaQz8AfF/",
    discourse: "https://community.fluck.site/",
    codeberg:  "https://codeberg.org/fluck/",
    github:    "https://github.com/flucksite/",
    email:     "mailto:info@fluck.site",
    # linkedin: "???",
    # rss:      "https://fluck.site/rss",
  }

  def render
    footer class: "switcher", data_limit: 3 do
      render_info_menu
      render_social_menu
      mount Shared::SubscriptionForm, list: "newsletter"
    end
  end

  private def render_info_menu
    nav do
      h2 r(".info.title").t
      ul role: "list" do
        {% for item in %i[about code_of_conduct] %}
          li do
            link r(".info.{{item.id}}").t, to: {{item.id.camelcase}}::Index
          end
        {% end %}
      end
    end
  end

  private def render_social_menu
    nav do
      h2 r(".social.title").t
      ul do
        {% for key, url in Shared::Footer::SOCIAL_MENU %}
          li do
            a r(".social.{{key.id}}").t, href: {{url}}
          end
        {% end %}
      end
    end
  end
end
