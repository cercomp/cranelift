class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
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

  def can?(action, controller)
    return true if current_user.admin?
    return false if current_user.role.nil?

    logger.debug "\n\n----\n#{controller}"

    current_user.role.permissions.each do |permission|
      if permission.controller == controller and permission.actions.split.include?(action)
        return true
        break
      end
    end
  end

  def redirect_if_cannot(action, controller)
    redirect_to root_url, :alert => t('application.unauthorized_access') unless can? action, controller
  end

  # Adiciona método de log
  include Log::CrLogger
  helper_method :log
end
