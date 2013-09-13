class ApplicationController < ActionController::Base
  protect_from_forgery

  include Cranelift::Auth
  include Log::CrLogger
end
