class SessionsController < ApplicationController

  def create
    user = UserAuthenticator.call(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      flash.now.notice = "Usuário logado"
      redirect_to incomings_path
    else
      redirect_to root_url, alert: "Email e/ou senha incorreto"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end
