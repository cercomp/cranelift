# encoding: utf-8
class Admin::Projects::RepositoriesController < Admin::BaseController
  helper_method :current_project

  def new
    @repository = current_project.repositories.new
  end

  def edit
    @repository = current_project.repositories.find(params[:id])
  end

  def create
    @repository = Repository.new(params[:repository])
    @repository.project = current_project

    if @repository.save
      log current_user, "Criou o repositório #{@repository.name} no projeto #{current_project.name}"
      redirect_to [current_project, @Repository], notice: 'Repository was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @repository = current_project.repositories.find(params[:id])

    begin
      params[:repository].slice!(:login, :password, :enable_autoupdate)
      params[:repository].delete(:password) if params[:repository][:password].empty?
    rescue NoMethodError
    end

    if @repository.update_attributes(params[:repository])
      log current_user, "Alterou o repositório #{@repository.name} no projeto #{current_project.name}"
      redirect_to current_project, notice: 'Repository was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @repository = current_project.repositories.find(params[:id])
    @repository.destroy

    log current_user, "Removeu o reposiotio #{@repository.name} no projeto #{current_project.name}"

    redirect_to current_project
  end

  private
  def current_project
    @current_project ||= ::Project.find(params[:project_id])
  end
end
