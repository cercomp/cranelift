class PagesController < ApplicationController
  def home
    redirect_to projects_path if current_user
  end
end
