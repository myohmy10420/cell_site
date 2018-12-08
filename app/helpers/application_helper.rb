module ApplicationHelper
  def render_dash_if_empty(value)
    value.empty? ? '-' : value
  end
end
