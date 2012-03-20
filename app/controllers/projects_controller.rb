# encoding: utf-8
class ProjectsController < ApplicationController
  before_filter :authenticate!
  before_filter :user_has_project, :only => [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.admin? ? Project.all : current_user.projects
  end


  def show
  end

  def new
    redirect_if_cannot 'new', 'project'
    @project = Project.new
  end

  def edit
    redirect_if_cannot 'edit', 'project'
  end

  def create
    redirect_if_cannot 'create', 'project'
    @project = Project.new(params[:project])

    if @project.save
      current_user.projects << @project
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    redirect_if_cannot 'update', 'project'

    if @project.update_attributes(params[:project])
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    redirect_if_cannot 'destroy', 'project'
    @project.destroy

    redirect_to projects_url
  end

  private
  def user_has_project
    @project = Project.find(params[:id])
    unless current_user.projects.include?(@project)
      redirect_to root_url, :alert => t('project.show.not_allowed') unless current_user.admin?
    end
  end
end
