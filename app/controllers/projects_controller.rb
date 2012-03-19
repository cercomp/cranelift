# encoding: utf-8
class ProjectsController < ApplicationController
  before_filter :authenticate!

  def index
    @projects = current_user.admin? ? Project.all : current_user.projects
  end

  def show
    @project = Project.find(params[:id])
    unless current_user.projects.include?(@project)
      redirect_to root_url, :alert => t('project.show.not_allowed') unless current_user.admin?
    end
  end

  # FIXME trabalhar permissões primeiro, pare verificar se um usuário poderá editar um projeto
  def new
    redirect_to root_url unless can? 'project', 'new'
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
