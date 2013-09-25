class ProfilesController < ApplicationController
  before_filter :authenticate!

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    params[:user].slice! :login,
                         :first_name,
                         :last_name,
                         :email,
                         :password,
                         :password_confirmation

    params[:user].except! :password,
                          :password_confirmation if params[:user][:password].blank?

    if @user.update_attributes params[:user]
      log @user, 'Atualizou seus dados'
      redirect_to root_url, notice: t('profiles.update.successfully_updated')
    else
      render :edit
    end
  end
end
