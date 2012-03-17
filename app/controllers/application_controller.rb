class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  def current_user
  	return @current_user || User.find(session[:user_id]) if session[:user_id]
  	false
  end

  def authenticate!
  	redirect_to(root_url, :alert => t('application.should_logged')) if !current_user
  end

  def noauthenticate!
  	redirect_to(root_url, :alert => t('application.shouldnot_logged')) if current_user
  end
end
