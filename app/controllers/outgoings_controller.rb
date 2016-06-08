class OutgoingsController < PlatformController

  before_filter :categories_for_user, only: [:new, :edit]

  def index
    @outgoings = Outgoing.by_user(current_user)
  end

  def new
    @outgoing = Outgoing.new
  end

  def edit
    @outgoing = Outgoing.find(params[:id])
  end

  def create
    @outgoing = Outgoing.new(outgoing_params)
    if @outgoing.save
      flash.now.notice = "Saída criada com sucesso."
      redirect_to action: :index
    else
      flash.now.alert = "Falha ao criar saída."
      categories_for_user
      render :new
    end
  end

  def update
    @outgoing = Outgoing.find(params[:id])
    if @outgoing.update(outgoing_params)
      flash.now.notice = "Saída atualizada com sucesso."
      redirect_to action: :edit
    else
      flash.now.alert = "Falha ao atualizar saída."
      categories_for_user
      render :edit
    end
  end

  def destroy
    @outgoing = Outgoing.find(params[:id])
    @outgoing.destroy
    redirect_to action: :index
  end

  private

  def categories_for_user
    @categories = Category.by_user_and_kind(current_user, Category.kinds[:outgoing])
  end

  def outgoing_params
    params.require(:outgoing).permit(:id, :category_id, :day, :value, :user_id)
  end

end
