module StoresHelper
  def render_store_line(store)
    if store.line_url.present? && store.line_ID.present?
      link_to store.line_url, target: '_blank' do
        [
          content_tag(:span, store.line_ID, class: 'font font--black font--200w'),
          image_tag('icons/stores_line_icon.jpeg', height: '25', class: 'store_line_icon')
        ].join('').html_safe
      end
    elsif store.line_url.present? && store.line_ID.blank?
      link_to image_tag('icons/stores_line_icon.jpeg', height: '25'), store.line_url, target: '_blank'
    elsif store.line_url.blank? && store.line_ID.present?
      content_tag :span, store.line_ID, class: 'font font--200w'
    else
      '-'
    end
  end
end
