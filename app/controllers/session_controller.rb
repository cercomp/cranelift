# encoding: utf-8
class SessionController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => 'Acesso confirmado'
    else
      flash[:warning] = 'Email ou senha inválidos'
      redirect_to :action => :new
    end
  end
  
  def destroy
    reset_session
    redirect_to root_url, :notice => 'Sessão encerrada!'
  end
end
