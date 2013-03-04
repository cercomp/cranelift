# encoding: utf-8
class Admin::Projects::RepositoriesController < ApplicationController
  before_filter :authenticate!, :only_admin!

  helper_method :current_project

  def index
    @repositories = current_project.repositories
  end

  def show
    @repository = current_project.repositories.find(params[:id])
  end

  def new
    @repository = Repository.new
  end

  def edit
    @repository = current_project.repositories.find(params[:id])
  end

  def create
    @repository = Repository.new(params[:repository])
    @repository.project = current_project

    if @repository.save
      log current_user, "Criou o repositório #{@repository.name} no projeto #{current_project.name}"
      redirect_to [:admin, current_project, :repositories], notice: 'Repository was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @repository = current_project.repositories.find(params[:id])

    begin
      params[:repository].slice!(:login, :password, :enable_autoupdate)
      params[:repository].delete(:password) if params[:repository][:password].empty?
    rescue
    end

    if @repository.update_attributes(params[:repository])
      log current_user, "Alterou o reposiotio #{@repository.name} no projeto #{current_project.name}"
      back_url = params[:back_url] || current_project
      redirect_to edit_admin_project_repository_path(current_project, @repository), notice: 'Repository was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @repository = current_project.repositories.find(params[:id])
    @repository.destroy

    log current_user, "Removeu o reposiotio #{@repository.name} no projeto #{current_project.name}"

    redirect_to [:admin, current_project, :repositories]
  end

  private
  def current_project
    @current_project ||= ::Project.find(params[:project_id])
  end
end
