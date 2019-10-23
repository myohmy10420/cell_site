module UsersHelper
  def render_human_sex(sex)
    return "-" if !sex
    sex == "male" ? "男" : "女"
  end

  def render_roles(roles)
    return if !roles.presence
    badge_tags = new_badge_tags_by(roles)
    badge_tags.join.html_safe
  end

  def new_badge_tags_by(roles)
    roles.map do |role|
      class_name = "badge badge-success"
      style = "margin-right: 5px"
      content_tag :span, human_role_name(role.name), class: class_name, style: style
    end
  end

  def human_role_name(name)
    case name
    when "admin"
      "管理員"
    when "store_manager"
      "店長"
    when "normal"
      "一般會員"
    else
      "未知角色"
    end
  end
end
