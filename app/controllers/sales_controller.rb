class SalesController < PlatformController

  def index
    @sales = Sale.by_user(current_user)
  end

  def new
    @sale = Sale.new
    5.times { @sale.sale_items.build }
    @clients = Client.by_user(current_user)
    @items = Item.by_user(current_user)
  end

  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      flash.now.notice = "Venda criada com sucesso."
      redirect_to action: :index
    else
      flash.now.alert = "Falha ao criar venda."
      @sale.sale_items.build
      @clients = Client.by_user(current_user)
      @items = Item.by_user(current_user)
      render :new
    end
  end

  private

  def sale_params
    params.require(:sale).permit(
      :id, :client_id, :date, :user_id, sale_items_attributes: [:id, :price, :item_id, :_destroy]
    )
  end

end
