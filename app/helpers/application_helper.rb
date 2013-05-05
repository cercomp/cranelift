module ApplicationHelper
  def admin_menu(icon_name, title, link, args = {})
    header_menu(icon_name, title, link, args) if can?('view', 'admin')
  end

  def header_menu(icon_name, title, link, args = {})
    args.reverse_merge!(:'data-toggle' => 'tooltip', :title => title)
    content_tag(:li, link_to(icon(icon_name), link, args))
  end

  def icon(name, color = 'icon-white')
    content_tag(:i, '', :class => "icon-#{name} #{color}")
  end
end
