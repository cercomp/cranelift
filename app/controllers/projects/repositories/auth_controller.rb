# encoding: utf-8
class Projects::Repositories::AuthController < ApplicationController
  def new
  end

  def create
    project = Project.find(params[:project_id])
    repository = Repository.find(params[:repository_id])

    if repository.auth(params[:login], params[:pass])
      redirect_to project_repository_url(project, repository)
    else
      render :new, :alert => 'dados errados'
    end
  end
end
