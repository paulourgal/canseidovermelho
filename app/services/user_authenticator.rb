class UserAuthenticator

  def self.call(email, password, options = {})
    self.new(email, password, options).call
  end

  attr_reader :email, :password

  def initialize(email, password, options)
    @email = email
    @password = password
  end

  def call
    user = User.find_by_email(email)

    if user.nil?
      { user: nil, error: "E-mail não cadastrado" }
    elsif !user.confirmed?
      { user: user, error: "Usuário não confirmou e-mail" }
    elsif !password_check(user)
      { user: user, error: "Senha incorreta" }
    else
      { user: user, error: "" }
    end

  end

  private

  def password_check(user)
    user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  end

end
