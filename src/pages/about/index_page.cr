class About::IndexPage < MainLayout
  def content
    render_hero
    render_bios
    render_story
  end

  def render_hero
    section class: "hero" do
      div class: "wrapper flow" do
        h1 do
          raw r(".hero.title").t
        end
        para r(".hero.text").t
      end
    end
  end

  def render_bios
    section do
      div class: "wrapper" do
        ul role: "list", class: "flow" do
          {% for person, index in %w[mick wout] %}
            li class: "person | switcher" do
              div class: "prose" do
                h2 r(".people.{{person.id}}.title").t
                para r(".people.{{person.id}}.text").t
                person_link r(".people.{{person.id}}.domain").t
              end
              {% for theme in %w[light dark] %}
                img src: asset("@images/people/{{person.id}}-{{theme.id}}-theme.png"),
                  alt: r(".people.{{person.id}}.alt").t,
                  class: "cutout",
                  data_shape: "circle-0{{index + 1}}",
                  data_for_theme: {{theme}}
              {% end %}
            end
          {% end %}
        end
      end
    end
  end

  def render_story
    article class: "centered" do
      div class: "prose flow" do
        h2 r(".story.title").t
        markdown r(".story.text").t
      end
    end
  end

  private def person_link(domain)
    a domain, href: "https://#{domain}", class: "shift"
  end
end
