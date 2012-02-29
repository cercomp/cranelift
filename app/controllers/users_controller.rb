class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect :show
    else
      render :new
    end
  end

  def edit
  end

  def update
  end
end
