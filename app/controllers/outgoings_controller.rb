class OutgoingsController < PlatformController

  def index
    @outgoings = Outgoing.by_user(current_user)
  end

  def new
    @outgoing = Outgoing.new
  end

  def create
    @outgoing = Outgoing.new(outgoing_params)
    if @outgoing.save
      flash.now.notice = "Saída criada com sucesso."
      redirect_to action: :index
    else
      flash.now.alert = "Falha ao criar saída."
      render :new
    end
  end

  private

  def outgoing_params
    params.require(:outgoing).permit(:id, :day, :kind, :value, :user_id)
  end

end
