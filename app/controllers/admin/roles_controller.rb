# TODO refatorar código, verificando o uso de rotas aninhadas:
# Exemplo de rota: role/:id/permissions
class Admin::RolesController < ApplicationController
  before_filter :authenticate!, :only_admin!

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
      redirect_to admin_roles_url, :notice => 'Permissao criada com sucesso'
    else
      render :add_permission
    end
  end

  def include_permission
    @role = Role.find(params[:id])
    @permission = Permission.find(params[:permission_id])

    @role.permissions << @permission
    redirect_to admin_roles_url, :notice => 'Permissao adicionado com sucesso'
  end
end
