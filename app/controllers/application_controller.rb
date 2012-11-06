class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :verify_ip

  def setting(st)
    Setting.find_or_default(st.to_s).value
  end

  # Adiciona método de log
  include Log::CrLogger
end
