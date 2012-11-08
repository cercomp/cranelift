class ApplicationController < ActionController::Base
  protect_from_forgery

  include Cranelift::Auth

  # Adiciona método de log
  include Log::CrLogger
end
