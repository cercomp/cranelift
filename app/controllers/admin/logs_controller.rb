class Admin::LogsController < ApplicationController
  before_filter :authenticate!, :only_admin!
  
  def index
    if params[:date].nil?
      @logs = Log.page(params[:page]).per(10)
    else
      day, month, year = params[:date].split('-')
      date = DateTime.new(year.to_i, month.to_i, day.to_i)
      condition = ['created_at > ? AND created_at < ?', date.beginning_of_day, date.end_of_day]
      @logs = Log.where(condition).page(params[:page]).per(4)
    end
  end
end
