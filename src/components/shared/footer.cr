class Shared::Footer < BaseComponent
  SOCIAL_MENU = {
    bluesky:  "https://bsky.app/profile/fluck.site/",
    mastodon: "https://indieweb.social/@fluck/",
    # discord:   "https://discord.gg/aycaQz8AfF/",
    # discourse: "https://community.fluck.site/",
    codeberg: "https://codeberg.org/fluck/",
    github:   "https://github.com/flucksite/",
    email:    "mailto:info@fluck.site",
    # linkedin: "???",
    # rss:      "https://fluck.site/rss",
  }

  def render
    footer class: "footer | wrapper" do
      div class: "footer__content | switcher" do
        div class: "couple" do
          render_info_menu
          render_social_menu
        end
        div class: "flow" do
          h2 r(".newsletter.title").t
          para r(".newsletter.text").t
          mount Shared::SubscriptionForm, tag: "newsletter"
          small r(".newsletter.disclaimer").t
        end
      end
      render_small_print
    end
  end

  private def render_info_menu
    nav class: "flow" do
      h2 r(".info.title").t
      ul class: "menu" do
        {% for item in %i[about code_of_conduct privacy_policy] %}
          li do
            link to: action = {{item.id.camelcase}}::Index,
              aria_current: current_page?(action) ? "page" : "false" do
              span r(".info.{{item.id}}").t, class: "shift"
            end
          end
        {% end %}
      end
    end
  end

  private def render_social_menu
    nav class: "flow" do
      h2 r(".social.title").t
      ul class: "menu" do
        {% for key, url in Shared::Footer::SOCIAL_MENU %}
          li do
            a href: {{url}} do
              inline_svg("social/{{key.id}}.svg")
              span r(".social.{{key.id}}").t, class: "shift"
            end
          end
        {% end %}
      end
    end
  end

  private def render_small_print
    div class: "footer__end | repel" do
      para r(".copyright").t(year: Time.local.year.to_s)
      para r(".principles").t
    end
  end
end
