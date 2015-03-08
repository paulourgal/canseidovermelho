class IncomingsController < ApplicationController

  def index
    if authenticated?
      @incomings = Incoming.by_user(current_user)
    else
      redirect_to root_url
    end
  end

  def new
    if authenticated?
      @incoming = Incoming.new
    else
      redirect_to root_url
    end
  end

  def create
    if authenticated?
      @incoming = Incoming.new(incoming_params)
      if @incoming.save
        flash.now.notice = "Entrada criada com sucesso."
        redirect_to action: :index
      else
        flash.now.alert = "Falha ao criar entrada."
        render :new
      end
    else
      redirect_to root_url
    end
  end

  private

  def incoming_params
    params.require(:incoming).permit(:id, :day, :kind, :value, :user_id)
  end

end
