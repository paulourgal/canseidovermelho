class SessionsController < ApplicationController

  def create
    user = UserAuthenticator.call(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      flash.now.notice = "Usuário logado"
      redirect_to incomings_path
    else
      flash.now.alert = "Email e/ou senha incorreto"
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
