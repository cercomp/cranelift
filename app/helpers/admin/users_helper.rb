module Admin::UsersHelper
  def user_login_with_status(user)
    color = user.active? ? 'color:#6c0' : 'color:#c30'
    text  = %{#{user.login}#{user.admin ? ' (admin)' : ''}}
    title = user.active ? '' : t('.user_inative')

    content_tag :span, text, :title => title, :style => color
  end
end
