# TODO colocar permissões
class Admin::Projects::RepositoriesController < ApplicationController
  before_filter :authenticate!, :only_admin!

  helper_method :current_project

  def index
    @repositories = current_project.repositories
  end

  def show
    @repository = current_project.repositories.find_by_name(params[:id])
  end

  def new
    @repository = Repository.new
  end

  def edit
    @repository = current_project.repositories.find_by_name(params[:id])
  end

  def create
    @repository = Repository.new(params[:repository])
    @repository.project = current_project

    if @repository.save
      log current_user, "Criou o reposiotio #{@repository.name} no projeto #{current_project.name}"
      redirect_to current_project, notice: 'Repository was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @repository = current_project.repositories.find_by_name(params[:id])

    # NOTE não é possível alterar o nome e a url de um repositório
    begin
      params[:repository].delete(:name) if params[:repository][:name]
      params[:repository].delete(:url) if params[:repository][:url]
      params[:repository].delete(:password) if params[:repository][:password].empty?
    rescue
    end

    if @repository.update_attributes(params[:repository])
      log current_user, "Alterou o reposiotio #{@repository.name} no projeto #{current_project.name}"
      back_url = params[:back_url] || current_project
      redirect_to back_url, notice: 'Repository was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @repository = current_project.repositories.find_by_name(params[:id])
    @repository.destroy

    log current_user, "Removeu o reposiotio #{@repository.name} no projeto #{current_project.name}"

    redirect_to current_project
  end

  private
  def current_project
    @current_project ||= ::Project.find_by_name(params[:project_id])
  end
end
