class SessionsController < ApplicationController

  def create
    result = UserAuthenticator.call(params[:email], params[:password])
    if result[:error].blank?
      cookies[:auth_token] = result[:user].auth_token
      flash.now.notice = "Usuário logado"
      redirect_to sales_path
    else
      redirect_to root_url, alert: result[:error]
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url
  end

end
