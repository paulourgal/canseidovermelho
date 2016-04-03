class IncomingsController < PlatformController

  def index
    @incomings = Incoming.by_user(current_user)
  end

  def new
    @incoming = Incoming.new
  end

  def create
    @incoming = Incoming.new(incoming_params)
    if @incoming.save
      flash.now.notice = "Entrada criada com sucesso."
      redirect_to action: :index
    else
      flash.now.alert = "Falha ao criar entrada."
      render :new
    end
  end

  private

  def incoming_params
    params.require(:incoming).permit(:id, :day, :kind, :value, :user_id)
  end

end
