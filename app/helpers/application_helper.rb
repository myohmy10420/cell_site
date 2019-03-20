module ApplicationHelper
  def render_dash_if_empty(value)
    value.presence ? value : '-'
  end
end
