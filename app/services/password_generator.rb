class PasswordGenerator

  def self.call(user, options = {})
    if (user.password.blank?)
      nil
    else
      self.new(user, options).call
    end
  end

  attr_reader :user

  def initialize(user, options = {})
    @user = user
  end

  def call
    encrypt_password
    user
  end

  private

  def encrypt_password
    @user.password_salt = BCrypt::Engine.generate_salt
    @user.password_hash = BCrypt::Engine
                           .hash_secret(user.password, user.password_salt)
  end

end
