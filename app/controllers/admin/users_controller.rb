# encoding: utf-8
class Admin::UsersController < ApplicationController
  before_filter :authenticate!, :only_admin!

  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def create
    params[:user].slice!(:login, :password, :password_confirmation, :admin, :ip_block, :name, :email, :role_id)
    @user = User.new(params[:user])

    if @user.save
      log current_user, "Criou o usuário #{@user.name}"
      redirect_to admin_users_url, :notice => t('users.create.successfully_create')
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    params[:user].slice!(:login, :password, :password_confirmation, :admin, :ip_block, :name, :email, :role_id)
    params[:user].except!(:password, :password_confirmation) if params[:user][:password].blank?

    if @user.update_attributes(params[:user])
      log current_user, "Atualizou o usuário #{@user.name}"
      redirect_to [:admin, @user], :notice => t('users.update.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy
    # TODO tradução aki
    redirect_to admin_users_url, :notice => 'Removido com sucesso'
    # TODO usuário poderão ser removidos??
  end
end
