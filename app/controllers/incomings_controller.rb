class IncomingsController < PlatformController

  before_filter :categories_for_user, only: [:new, :edit]

  def index
    @incomings = Incoming.by_user(current_user)
  end

  def new
    @incoming = Incoming.new
  end

  def edit
    @incoming = Incoming.find(params[:id])
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

  def update
    @incoming = Incoming.find(params[:id])
    if @incoming.update(incoming_params)
      flash.now.notice = "Entrada atualizada com sucesso."
      redirect_to action: :edit
    else
      flash.now.alert = "Falha ao atualizar entrada."
      render :edit
    end
  end

  def destroy
    @incoming = Incoming.find(params[:id])
    @incoming.destroy
    redirect_to action: :index
  end

  private

  def categories_for_user
    @categories = Category.by_user_and_kind(current_user, Category.kinds[:incoming])
  end

  def incoming_params
    params.require(:incoming).permit(:id, :category_id, :day, :value, :user_id)
  end

end
