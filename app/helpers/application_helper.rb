module ApplicationHelper
  def admin_menu_item(icon_name, title, link, args={})
    menu_item(icon_name, title, link, args) if can?('view', 'admin')
  end

  def menu_item(icon_name, title, link, args={})
    args.reverse_merge!(:'data-toggle' => 'tooltip', :title => title)
    content_tag :li do
      link_to link, args do
        raw "#{icon icon_name}<br /> #{title}"
      end
    end
  end

  def icon(name, color='#3B3B41')
    content_tag :span, '', class: "glyphicon glyphicon-#{name}", style: "color: #{color};"
  end
end
