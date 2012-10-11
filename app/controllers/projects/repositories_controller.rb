# TODO colocar permissões
class Projects::RepositoriesController < ApplicationController
  before_filter :authenticate!

  helper_method :current_project

  def index
    @repositories = current_project.repositories
  end

  def show
    @repository = Repository.find(params[:id])
  end

  def update
    @repository = Repository.find(params[:id])
    @repository.update_attribute :version, params[:repository][:version]
    redirect_to @repository.project, :notice => 'Repositorio atualizado com sucsso'
  end

  private
  def current_project
    @current_project ||= Project.find(params[:project_id])
  end
end
