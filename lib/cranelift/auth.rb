module Cranelift::Auth
  
  extend ActiveSupport::Concern

  included do
    before_filter :verify_ip

    helper_method :current_user
    helper_method :can?
    helper_method :log
  end

  def verify_ip
    return true unless current_user

    allowed_pages = [root_url, login_url]
    if allowed_pages.include?(request.original_url) or
        Setting.find_or_default('block_ip').value == 'false' or
        current_user.admin? or
        !current_user.ip_block?
      return true
    end

    unless Ip.all.any? {|ip| ip.allowed? (request.remote_ip) }
      reset_session
      redirect_to root_url, :notice => t('application.ip_not_allowed')
    end
  end

  def verify_permission
    redirect_if_cannot action_name, controller_name
  end

  def current_user
  	return (@current_user ||= User.find(session[:user_id])) if session[:user_id]
  	false
  end

  def authenticate!
  	redirect_to(root_url, :alert => t('application.should_logged')) if !current_user
  end

  def noauthenticate!
  	redirect_to(root_url, :alert => t('application.shouldnot_logged')) if current_user
  end

  def only_admin!
    redirect_if_cannot('view', 'admin')
  end

  def can?(action, controller)
    return false  if current_user == false
    return true   if current_user.admin?
    return false  if current_user.role.nil?

    current_user.role.permissions.each do |permission|
      return true if permission.controller == controller and
                     (permission.actions.split.include?(action) or permission.actions == 'all')
    end

    return false
  end

  def redirect_if_cannot(action, controller)
    redirect_to root_url, :alert => t('application.unauthorized_access') unless can?(action, controller)
  end
end

ApplicationController.send(:include, Cranelift::Auth)
