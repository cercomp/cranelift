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

  private
  def current_project
    @current_project ||= Project.find(params[:project_id])
  end
end
