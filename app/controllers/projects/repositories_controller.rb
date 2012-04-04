# TODO colocar permissões
class Projects::RepositoriesController < ApplicationController
  before_filter :authenticate!
  before_filter :assign_project

  def index
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find(params[:id])
  end

  def new
    @repository = Repository.new
  end

  def edit
    @repository = Repository.find(params[:id])
  end

  def create
    @repository = Repository.new(params[:repository])

    if @repository.save
      redirect_to [@current_project, @repository], notice: 'Repository was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @repository = Repository.find(params[:id])

    if @repository.update_attributes(params[:repository])
      redirect_to [@current_project, @repository], notice: 'Repository was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @repository = Repository.find(params[:id])
    @repository.destroy

    redirect_to project_repositories_url(@current_project)
  end

  private
  def assign_project
    @current_project = Project.find(params[:project_id])
  end
end
