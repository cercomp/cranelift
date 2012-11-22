# TODO colocar permissões
class Projects::RepositoriesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :update

  before_filter :authenticate!, :except => :update
  before_filter :verify_local_access, :only => :update

  helper_method :current_project

  def index
    @repositories = current_project.repositories
  end

  def show
    @repository = current_project.repositories.find_by_name(params[:id])
  end

  def update
    @repository = current_project.repositories.find_by_name(params[:id])
    @repository.version = params[:repository][:version]
    @repository.save
    redirect_to @repository.project, :notice => 'Repositorio atualizado com sucsso'
  end

  private
  def current_project
    @current_project ||= Project.find_by_name(params[:project_id])
  end

  def verify_local_access
    authenticate! unless local_access? 
  end

  # TODO
  def local_access?
    true
  end
end
