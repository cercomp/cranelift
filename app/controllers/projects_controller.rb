# encoding: utf-8
class ProjectsController < ApplicationController
  before_filter :authenticate!
  before_filter :user_has_project, :only => [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.projects
  end

  def show
  end

  private
  def user_has_project
    @project = Project.find(params[:id])
    unless current_user.projects.include?(@project)
      redirect_to root_url, :alert => t('project.show.not_allowed') unless current_user.admin?
    end
  end
end
