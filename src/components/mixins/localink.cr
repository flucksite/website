module Localink
  macro localink(label = nil, **options, &block)
    {%
      args = options.to_a.reject { |option| option[0] == :to }
      to = options[:to]
      str_to = to.stringify
      if str_to.includes?("locale:")
        localized_to = str_to
      elsif str_to.ends_with?(")")
        localized_to = str_to.gsub(/\)$/, ", locale: Rosetta.locale)")
      else
        localized_to = "#{str_to.id}.with(locale: Rosetta.locale)"
      end
    %}

    # to = Rosetta.locale == Rosetta.default_locale ? {{to}} : {{localized_to.id}}
    to = {{to}}

    {% if block %}
      link to{% for a in args %}, {{a[0].id}}: {{a[1]}}{% end %} do
        {{block.body}}
      end
    {% else %}
      link {{label}}, to{% for a in args %}, {{a[0].id}}: {{a[1]}}{% end %}
    {% end %}
  end
end
