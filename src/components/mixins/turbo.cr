module Turbo
  def turbo_morph_tag
    meta name: "turbo-refresh-method", content: "morph"
  end

  def turbo_view_transition_tag
    meta name: "view-transition", content: "same-origin"
  end

  def turbo_frame(**args, &)
    tag("turbo-frame", **args) do
      yield
    end
  end
end
