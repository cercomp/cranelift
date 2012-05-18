# encoding: utf-8
class Admin::ProjectsController < ApplicationController
  before_filter :authenticate!, :only_admin!
  before_filter :find_users_by_param, :only => [:create, :update]

  def index
    @projects = ::Project.page(params[:page]).per(10)
  end

  def show
    @project = ::Project.find(params[:id])
  end

  def new
    redirect_if_cannot 'new', 'projects'
    @project = Project.new
  end

  def edit
    redirect_if_cannot 'edit', 'projects'
    @project = Project.find(params[:id])
  end

  def create
    redirect_if_cannot 'create', 'projects'

    @project = Project.new(params[:project])

    if @project.save
      log current_user, "Criou o projeto : #{@project.name}"
      redirect_to [:admin, @project], notice: t('application.obj_successfully_created', :obj => 'Projeto')
    else
      render action: "new"
    end
  end

  def update
    redirect_if_cannot 'update', 'projects'

    @project = Project.find(params[:id])

    if @project.update_attributes(params[:project])
      log current_user, "Modificou o projeto : #{@project.name}"
      redirect_to [:admin, @project], notice: t('application.obj_successfully_updated', :obj => 'Projeto')
    else
      render action: "edit"
    end
  end

  def destroy
    redirect_if_cannot 'destroy', 'projects'
    @project = Project.find(params[:id])
    @project.destroy

    log current_user, "Removeu o projeto : #{@project.name}"

    redirect_to admin_projects_url
  end

  private
  def find_users_by_param
    params[:project][:users].map!{ |i| User.find(i) } unless params[:project][:users].nil?
  end
end
