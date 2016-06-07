class CategoriesController < PlatformController

  def index
    @categories = Category.by_user(current_user)
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash.now.notice = "Categoria criada com sucesso."
      redirect_to action: :index
    else
      flash.now.alert = "Falha ao criar categoria."
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash.now.notice = "Categoria atualizado com sucesso."
      redirect_to action: :edit
    else
      flash.now.alert = "Falha ao atualizar categoria."
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to action: :index
  end

  private

  def category_params
    params.require(:category).permit(:id, :kind, :name, :user_id)
  end

end
