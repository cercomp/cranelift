# encoding: utf-8
class PasswordResetsController < ApplicationController
  def new
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset if user
      flash.notice = 'Email enviado com instruções'
    else
      flash.alert = 'Email não cadastrado no sistema'
    end
    redirect_to root_url
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Este link de recuperação de senha expirou"
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Senha atualizada com sucesso"
    else
      render :edit
    end
  end
end
