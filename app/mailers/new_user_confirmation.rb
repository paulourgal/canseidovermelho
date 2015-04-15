class NewUserConfirmation < ActionMailer::Base
  default from: "canseidovermelho@gmail.com"

  def user_confirmation(user)
    @user = user
    mail(to: @user.email, subject: "Confirmação de cadastro")
  end
end
