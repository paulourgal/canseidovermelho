class OutgoingsController < PlatformController

  def index
    @outgoings = Outgoing.by_user(current_user)
  end

  def new
    @outgoing = Outgoing.new
    @categories = categories_for_user
  end

  def create
    @outgoing = Outgoing.new(outgoing_params)
    if @outgoing.save
      flash.now.notice = "Saída criada com sucesso."
      redirect_to action: :index
    else
      flash.now.alert = "Falha ao criar saída."
      @categories = categories_for_user
      render :new
    end
  end

  private

  def categories_for_user
    Category.by_user_and_kind(current_user, Category.kinds[:outgoing])
  end

  def outgoing_params
    params.require(:outgoing).permit(:id, :category_id, :day, :value, :user_id)
  end

end
