# encoding: utf-8
class Admin::LogsController < Admin::BaseController
  def index
    # TODO scope
    if params[:date].nil?
      @logs = Log.page(params[:page]).per(10)
    else
      day, month, year = params[:date].split('-')
      date = DateTime.new(year.to_i, month.to_i, day.to_i)
      condition = ['created_at > ? AND created_at < ?', date.beginning_of_day, date.end_of_day]

      @logs = Log.where(condition).page(params[:page]).per(10)
    end
  end
end
