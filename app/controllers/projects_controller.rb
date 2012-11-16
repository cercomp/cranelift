# encoding: utf-8
class ProjectsController < ApplicationController
  before_filter :authenticate!
  before_filter :user_has_project, :only => :show

  def index
    @projects = (current_user.admin? ? Project.name_asc : current_user.projects).page(params[:page]).per(25)
  end

  def show
  end

  private
  def user_has_project
    @project = Project.find_by_name(params[:id])
    if !current_user.admin? && !current_user.projects.include?(@project)
      redirect_to root_url, :alert => t('project.show.not_allowed') unless current_user.admin?
    end
  end
end
