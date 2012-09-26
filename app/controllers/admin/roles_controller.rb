# TODO refatorar código, verificando o uso de rotas aninhadas:
# Exemplo de rota: role/:id/permissions
class Admin::RolesController < ApplicationController
  before_filter :authenticate!, :only_admin!, :verify_permission

  def index
    @roles = Role.all
  end

  def edit
    @roles = Role.all
  end

  def add_permission
    @role = Role.find(params[:id])
    @permission = Permission.new
    @permissions = Permission.all
  end

  def save_permission
    @role = Role.find(params[:id])
    @permission = Permission.new params[:permission]

    if @permission.save
      @role.permissions << @permission
      redirect_to admin_roles_url, :notice => t('application.obj_successfully_created', :obj => Permission.model_name.human) 
    else
      render :add_permission
    end
  end

  def include_permission
    @role = Role.find(params[:id])
    @permission = Permission.find(params[:permission_id])

    @role.permissions << @permission
    redirect_to admin_roles_url, :notice => t('application.obj_successfully_added', :obj => Permission.model_name.human)
  end

  def remove_permission
    @role = Role.find(params[:id])
    @permission = Permission.find(params[:permission_id])
    @role.permissions.delete(@permission)
    
    redirect_to admin_roles_url, :notice => t('application.obj_successfully_destroyed', :obj => Permission.model_name.human)
  end
end
