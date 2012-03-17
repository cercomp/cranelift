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
  end
end
