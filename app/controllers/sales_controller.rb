class SalesController < PlatformController

  before_filter :get_clients_and_items, only: [:new, :edit]

  def index
    @sales = Sale.by_user(current_user)
  end

  def new
    @sale = Sale.new
    5.times { @sale.sale_items.build }
  end

  def edit
    @sale = Sale.find(params[:id])
  end

  def create
    @sale = Sale.new(sale_params)
    if SellItems.call(@sale)
      flash.now.notice = "Venda criada com sucesso."
      redirect_to action: :index
    else
      flash.now.alert = "Falha ao criar venda."
      @sale.sale_items.build
      get_clients_and_items
      render :new
    end
  end

  def update
    @sale = Sale.find(params[:id])
    if @sale.update(sale_params)
      flash.now.notice = "Venda atualiza com sucesso"
      redirect_to action: :edit
    else
      flash.now.alert = "Falha ao atualizar venda."
      get_clients_and_items
      render :edit
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy
    redirect_to action: :index
  end

  private

  def get_clients_and_items
    @clients = Client.by_user(current_user)
    @items = Item.by_user(current_user)
  end

  def sale_params
    params.require(:sale).permit(
      :id, :client_id, :date, :user_id,
      sale_items_attributes: [:id, :item_id, :price, :quantity, :_destroy]
    )
  end

end
