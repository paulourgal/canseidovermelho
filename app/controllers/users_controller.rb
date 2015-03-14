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
      flash.now.notice = "Usuário criado com sucesso."
      redirect_to action: :index
    else
      flash.now.alert = "Erro ao criar usuário."
      render :new
    end
  end

  private

  def user_param
    params.require(:user).permit(
      :birth_date, :confirmed, :email, :name,
      :password, :password_confirmation, :role
    )
  end

end
