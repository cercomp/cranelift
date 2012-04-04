class UsersController < ApplicationController
  before_filter :authenticate!, :except => [:new, :create]
  before_filter :noauthenticate!, :only => [:new, :create]

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to login_url, :notice => t('users.create.successfully_create')
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    params[:user].slice!(:name, :password, :password_confirmation)
    params[:user].except!(:password, :password_confirmation) if params[:user][:password].blank?

    if @user.update_attributes params[:user]
      redirect_to @user, :notice => t('users.update.successfully_updated')
    else
      render :edit
    end
  end
end
