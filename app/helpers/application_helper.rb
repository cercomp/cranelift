module ApplicationHelper
  def admin_menu_item(icon_name, path, title, link, args={})
    menu_item(icon_name, path, title, link, args) if can?('view', 'admin')
  end

  def menu_item(icon_name, path, title, link, args={})
    args.reverse_merge!(:'data-toggle' => 'tooltip', :title => title)
    content_tag :li, class: active_path(path) do
      link_to link, args do
        raw "#{icon icon_name, (active_path(path) ? 'white' : '')}<br /> #{title}"
      end
    end
  end

  def icon(name, color='#3B3B41')
    content_tag :span, '', class: "glyphicon glyphicon-#{name}", style: "color: #{color};"
  end

  def active_path path
    return 'active' if request.path.include? path
  end
end
