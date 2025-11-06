class LocaleSwitcher < BaseComponent
  LOCALE_PATH_REGEX = %r{^\/(?:#{Rosetta.available_locales.join("|")})?(?:\/)?(.*)}

  def render
    nav class: "locale-switcher", aria_labelledby: "locale_switcher_label" do
      span r(".label").t, class: "visually-hidden"
      ul class: "menu", data_direction: "horizontal" do
        Rosetta.available_locales.each do |locale|
          li do
            a locale, href: path_for_locale(locale),
              aria_current: locale == Rosetta.locale
          end
        end
      end
    end
  end

  private def path_for_locale(locale)
    String.build do |io|
      parts = context.request.path.match(LOCALE_PATH_REGEX)
      io << "/" << locale unless locale == Rosetta.default_locale
      if path = parts.try(&.[1]?)
        io << "/" << path
      end
    end
  end
end
