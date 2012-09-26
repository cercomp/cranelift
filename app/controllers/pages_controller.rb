class PagesController < ApplicationController
  def home
    redirect_to projects_path if current_user
    render 'session/new' unless current_user
  end
end
