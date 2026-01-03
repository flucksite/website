module Revealable
  private def render_early_access
    section class: "centered", data_max_with: "prose" do
      mount EarlyAccess
    end
  end

  macro reveal_attr(start = "down", once = true, threshold = nil)
    {%
      intersect = "x-intersect"
      intersect = "#{intersect.id}.once" if once
      intersect = "#{intersect.id}.threshold.#{threshold}" if threshold
    %}

    { x_data: "reveal", {{intersect}}: "show", data_start: {{start}} }
  end
end
