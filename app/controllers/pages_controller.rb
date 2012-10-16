class PagesController < ApplicationController
  def home
    redirect_to current_user ? projects_url : login_url
  end
end
