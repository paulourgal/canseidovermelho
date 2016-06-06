class ItemsController < PlatformController

  def index
    @items = Item.by_user(current_user)
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
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

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash.now.notice = "Item atualizado com sucesso."
      redirect_to action: :edit
    else
      flash.now.alert = "Falha ao atualizar item."
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to action: :index
  end

  private

  def item_params
    params.require(:item)
      .permit(:id, :cost_price, :description, :name, :quantity, :status, :unitary_price, :user_id)
  end

end
