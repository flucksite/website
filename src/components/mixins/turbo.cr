module Turbo
  def turbo_frame(**args, &)
    tag("turbo-frame", **args) do
      yield
    end
  end
end
