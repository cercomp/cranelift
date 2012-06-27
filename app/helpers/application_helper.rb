module ApplicationHelper
  def admin_menu(label, link, icon = '')
    raw content_tag(:li, link_to(icon + t(".#{label}"), link)) if can?('view', 'admin')
  end

  def icon(name, color = '')
    color.size != 0 and color = 'icon-white'
    name = %`icon-#{name}`

    content_tag :i, '', :class => %`#{name} #{color}`
  end
end
