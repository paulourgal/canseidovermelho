class UsersController < ApplicationController

  def index
    if authenticated?
      @users = User.all
    else
      redirect_to sign_up_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_param)

    if UserCreator.call(@user)
      flash.notice = "Usuário cadastrado com sucesso."
      redirect_to root_url
    else
      flash.now.alert = "Falha ao cadastrar novo usuário."
      render :new
    end
  end

  # FIXME: action confirmation with VERB GET
  def confirmation
    @user = User.find(params[:id])
    @user.confirmed!
    redirect_to root_url
  end

  private

  def user_param
    params.require(:user).permit(
      :birth_date, :confirmed, :email, :name,
      :password, :password_confirmation, :role
    )
  end

end
