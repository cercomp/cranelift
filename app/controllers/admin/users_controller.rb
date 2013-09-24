# encoding: utf-8
class Admin::UsersController < ApplicationController
  before_filter :authenticate!, :only_admin!

  def index
    @users = User.order('LOWER(first_name)').page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def create
    params[:user].slice! :login,
                         :first_name,
                         :last_name,
                         :email,
                         :password,
                         :password_confirmation,
                         :admin,
                         :role_id,
                         :ip_block,
                         :active,
                         :login_type

    @user = User.new(params[:user])

    if @user.save
      log current_user, "Criou o usuário #{@user.name}"
      redirect_to admin_users_url, :notice => 'Usuário cadastrado com sucesso.'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    params[:user].slice! :login,
                         :first_name,
                         :last_name,
                         :email,
                         :password,
                         :password_confirmation,
                         :admin,
                         :role_id,
                         :ip_block,
                         :active,
                         :login_type

    params[:user].except! :password,
                          :password_confirmation if params[:user][:password].blank?

    if @user.update_attributes params[:user]
      log current_user, "Atualizou o usuário #{@user.name}"
      redirect_to admin_users_url, :notice => t('profiles.update.successfully_updated')
    else
      render :edit
    end
  end

  def activate
    redirect_to admin_users_url, :notice => 'Habilitado com sucesso' if toogle_active
  end

  def inactivate
    redirect_to admin_users_url, :notice => 'Desabilitado com sucesso' if toogle_active
  end

  private

  def toogle_active
    @user = User.find(params[:id])
    @user.update_attribute :active, !@user.active
  end
end
