class ItemsController < PlatformController

  def index
    @items = Item.by_user(current_user)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash.now.notice = "Item criado com sucesso."
      redirect_to action: :index
    else
      flash.now.alert = "Falha ao criar item."
      render :new
    end
  end

  private

  def item_params
    params.require(:item)
      .permit(:id, :cost_price, :description, :name, :quantity, :status, :unitary_price, :user_id)
  end

end
