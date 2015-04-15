class PasswordResetter

  def self.call(email, options = {})
    self.new(email, options).call
  end

  attr_reader :email

  def initialize(email, options)
    @email = email
  end

  def call
    user = User.find_by_email(email)
    if user.nil?
      { success: false, msg: "E-mail inválido." }
    else
      setup_password_reset_for(user)
      UserPasswordReset.password_reset(user).deliver
      { success: true, msg: "E-mail enviado com as instruções para alterar a senha." }
    end
  end

  private

  def setup_password_reset_for(user)
    begin
      user.password_reset_token = SecureRandom.urlsafe_base64
    end while User.exists?(password_reset_token: user.password_reset_token)
    user.password_reset_sent_at = Time.zone.now
    user.save!
  end

end
