class ApplicationController < ActionController::Base
  protect_from_forgery

  # Adiciona método de log
  include Log::CrLogger
end
