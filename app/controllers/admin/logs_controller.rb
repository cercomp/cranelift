class Admin::LogsController < ApplicationController
  before_filter :authenticate!
  
  def index
    @logs = Log.paginate(:page => params[:page])
  end
end
