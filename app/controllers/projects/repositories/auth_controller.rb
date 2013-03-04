# encoding: utf-8
class Projects::Repositories::AuthController < ApplicationController
  before_filter :load_vars

  def new
  end

  def create
    project = Project.find(params[:project_id])
    repository = Repository.find(params[:repository_id])

    if repository.auth(params[:login], params[:pass])
      redirect_to project_repository_url(project, repository)
    else
      flash.now['alert'] = t('projects.repositories.auth.create.auth_failed')
      render :new
    end
  end

  private
  def load_vars
    @project = Project.find(params[:project_id])
    @repository = Repository.find(params[:repository_id])
  end
end
