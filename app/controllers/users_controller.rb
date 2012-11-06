class UsersController < ApplicationController
  before_filter :authenticate!, :except => [:new, :create]
  before_filter :noauthenticate!, :only => [:new, :create]

  before_filter :allow_register?, :only => [:new, :create]

  def index
    @users = User.order('LOWER(name)').page(params[:page]).per(20)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      log @user, 'Se cadastrou no sistema'
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
      log @user, 'Atualizou seus dados'
      redirect_to @user, :notice => t('users.update.successfully_updated')
    else
      render :edit
    end
  end

private
  def allow_register?
    
    if Setting.find_or_default('allow_register').value == 'false'
      redirect_to root_url, :alert => t('users.alert.not_allow_register')
    end
  end
end
