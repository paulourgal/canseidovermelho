class PasswordResetsController < ApplicationController
  before_filter :find_user, only: [:edit, :update]

  def new
  end

  def create
    result = PasswordResetter.call(params[:email])
    if result[:success]
      flash[:notice] = result[:msg]
      redirect_to root_url
    else
      flash[:alert] = result[:msg]
      render :new
    end
  end

  def edit
    if @user.nil? || @user.password_reset_sent_at < 2.hours.ago
      flash[:alert] = I18n.t('password_resets.edit.password_reset_expired')
      redirect_to root_url
    else
      flash[:alert] = ""
    end
  end

  def update
    if @user.nil?
      flash[:alert] = "Password Resetter Invalid"
      redirect_to root_url
    elsif update_user_password?
      @user = PasswordGenerator.call(@user)
      @user.save
      flash[:notice] = "Password Changed"
      redirect_to root_url
    else
      flash[:alert] = "Password Wrong"
      redirect_to edit_password_reset_path(params[:id])
    end
  end

  private

  def find_user
    @user = User.find_by(password_reset_token: params[:id])
  end

  def update_user_password?
    password = params[:user][:password]

    if password.blank? || password != params[:user][:password_confirmation]
      false
    else
      @user.password = params[:user][:password]
      true
    end
  end

end
