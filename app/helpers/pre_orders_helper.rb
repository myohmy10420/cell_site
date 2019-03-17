module PreOrdersHelper
  def render_pre_order_btn(product)
    if current_user
      if user_have_pre_ordered(@product)
        content_tag :button, "您已預購", class: "btn btn--red"
      else
        content_tag :button, "我要預購", class: "btn btn--red", data: {
          toggle: "modal",
          target: "#pre_order_modal"
        }
      end
    else
      link_to new_user_session_path do
        content_tag :button, "我要預購", class: "btn btn--red"
      end
    end
  end

  def user_have_pre_ordered(product)
    current_user.pre_orders.where(product_id: product.id).presence
  end
end
