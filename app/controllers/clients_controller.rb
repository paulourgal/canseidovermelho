class ClientsController < PlatformController

  def index
    @clients = Client.by_user(current_user)
  end

  def new
    @client = Client.new
  end

  def edit
    @client = Client.find(params[:id])
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash.now.notice = "Cliente criado com sucesso."
      redirect_to action: :index
    else
      flash.now.alert = "Falha ao criar cliente."
      render :new
    end
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      flash.now.notice = "Cliente atualizado com sucesso."
      redirect_to action: :edit
    else
      flash.now.alert = "Falha ao atualizar cliente."
      render :edit
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to action: :index
  end

  private

  def client_params
    params.require(:client).permit(
      :id, :address, :email, :name, :phone, :observations, :status, :user_id
    )
  end

end
