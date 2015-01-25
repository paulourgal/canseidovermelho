class UserCreator

  def self.call(user, options = {})
    self.new(user, options).call
  end

  attr_reader :user

  def initialize(user, options)
    @user = user
  end


  def call
    if user.valid?
      save_user
    else
      false
    end
  end

  private

  def encrypt_password
    user.password_salt = BCrypt::Engine.generate_salt
    user.password_hash = BCrypt::Engine
                           .hash_secret(user.password, user.password_salt)
  end

  def save_user
    encrypt_password

    if user.save
      true
    else
      false
    end
  end

end
