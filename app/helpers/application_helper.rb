module ApplicationHelper
  def admin_menu(label, link)
    raw content_tag(:li, link_to(t(".#{label}"), link)) if can?('view', 'admin')
  end
end
