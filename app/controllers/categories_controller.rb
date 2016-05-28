class CategoriesController < PlatformController

  def index
    @categories = Category.by_user(current_user)
  end

  def new
    @category = Category.new
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

  private

  def category_params
    params.require(:category).permit(:id, :kind, :name, :user_id)
  end

end
