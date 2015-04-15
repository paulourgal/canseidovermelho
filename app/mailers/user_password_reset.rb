class UserPasswordReset < ActionMailer::Base
  default from: "canseidovermelho@gmail.com"

  def password_reset(user)
    @user = user
    mail(to: @user.email, subject: "Alteração da senha")
  end
end
