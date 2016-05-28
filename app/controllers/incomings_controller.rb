class IncomingsController < PlatformController

  def index
    @incomings = Incoming.by_user(current_user)
  end

  def new
    @incoming = Incoming.new
    @categories = categories_for_user
  end

  def create
    @incoming = Incoming.new(incoming_params)
    if @incoming.save
      flash.now.notice = "Entrada criada com sucesso."
      redirect_to action: :index
    else
      flash.now.alert = "Falha ao criar entrada."
      @categories = categories_for_user
      render :new
    end
  end

  private

  def categories_for_user
    Category.by_user_and_kind(current_user, Category.kinds[:incoming])
  end

  def incoming_params
    params.require(:incoming).permit(:id, :category_id, :day, :value, :user_id)
  end

end
