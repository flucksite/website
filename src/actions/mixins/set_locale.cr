module SetLocale
  macro included
    before set_locale
  end

  private def set_locale
    Rosetta.locale = cookies.get?(:locale) ||
                     params.get?(:locale) ||
                     Rosetta.default_locale

    continue
  end
end
