module SetLanguage
  macro included
    before set_language
  end

  private def set_language
    if language = cookies.get?(:language) || params.get?(:language)
      Rosetta.locale = language
    end

    continue
  end
end
