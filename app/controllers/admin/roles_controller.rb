# encoding: utf-8

# TODO refatorar código, verificando o uso de rotas aninhadas: Exemplo de rota: role/:id/permissions
class Admin::RolesController < Admin::BaseController
  before_filter :set_role, only: [:add_permission, :save_permission, :include_permission, :remove_permission]
  before_filter :set_permission, only: [:include_permission, :remove_permission]

  def index
    @roles = Role.all
  end

  def add_permission
    @permission = Permission.new
    @permissions = Permission.all
  end

  def save_permission
    @permission = Permission.new params[:permission]

    if @permission.save
      @role.permissions << @permission

      redirect_to admin_roles_url, notice: t('application.obj_successfully_created', obj: Permission.model_name.human) 
    else
      render :add_permission
    end
  end

  def include_permission
    @role.permissions << @permission

    redirect_to admin_roles_url, notice: t('application.obj_successfully_added', obj: Permission.model_name.human)
  end

  def remove_permission
    @role.permissions.delete(@permission)

    redirect_to admin_roles_url, notice: t('application.obj_successfully_destroyed', obj: Permission.model_name.human)
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def set_permission
    @permission = Permission.find(params[:permission_id])
  end
end
