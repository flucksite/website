# auto_register: false
# frozen_string_literal: true

module FluckWebsite
  module Views
    module Helpers
      module Form
        def field(
          label:,
          name:,
          type: "text",
          autocomplete: nil,
          autofocus: false,
          required: false,
          value: nil,
          error: nil,
          **extra_attrs
        )
          tag.div(class: "field") do
            escape_join([
              tag.label(label, for: name),
              tag.input(
                type: type,
                name: name,
                id: name,
                required: required,
                autocomplete: autocomplete,
                autofocus: autofocus || nil,
                value: value,
                **extra_attrs
              ),
              field_error(error)
            ])
          end
        end

        def field_error(text)
          return unless text

          tag.div(text, class: "field__error")
        end

        def submit_button(key)
          tag.button(
            t(key),
            type: "submit",
            class: "button",
            data: {level: "primary"}
          )
        end
      end
    end
  end
end
