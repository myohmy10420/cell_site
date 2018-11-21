module VariantsHelper
  def render_telecommunication_name(variant)
    telecommunication = Telecommunication.find_by(id: variant.telecommunication_id)
    telecommunication.name || "-"
  end
end
