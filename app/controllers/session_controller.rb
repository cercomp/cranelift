# encoding: utf-8
class SessionController < ApplicationController
  before_filter :noauthenticate!, except: :logout
  before_filter :authenticate!, only: :logout
  before_filter :require_allow_signup?, only: [:signup, :create_user]

  helper_method :deny_signup?

  def login
  end

  def create_session
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Acesso confirmado'
    else
      flash[:warning] = 'Email ou senha inválidos'
      render :login
    end
  end
  
  def logout
    reset_session
    redirect_to root_url
  end

  def signup
    @user = User.new
  end

  def create_user
    @user = User.new(params[:user])
    if @user.save
      log @user, 'Se cadastrou no sistema'
      redirect_to login_url, notice: 'Cadastrado com sucesso'
    else
      render :signup
    end
  end

  def forgot_password
  end

  def restore_password
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset if user
      flash.notice = 'Email enviado com instruções'
    else
      flash.alert = 'Email não cadastrado no sistema'
    end
    redirect_to login_url
  end

  def reset_password
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update_password
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to forgot_password_path, alert: "Este link de recuperação de senha expirou"
    elsif @user.update_attributes(params[:user])
      redirect_to login_url, notice: "Senha atualizada com sucesso"
    else
      render :reset_password
    end
  end

  private

  def deny_signup?
    return Setting.find_or_default('allow_register').value == 'false'
  end

  def require_allow_signup?
    redirect_to login_url, alert: t('session.alert.not_allow_register') if deny_signup?
  end
end
