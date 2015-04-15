class UserCreator

  def self.call(user, options = {})
    self.new(user, options).call
  end

  attr_reader :user

  def initialize(user, options)
    @user = user
  end


  def call
    create_user
  end

  private

  def create_user
    @user = PasswordGenerator.call(user)
    return false if user.nil?

    generate_auth_token
    save_user
  end

  def generate_auth_token
    begin
      @user.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: @user.auth_token)
  end

  def save_user
    if user.save
      send_confirmation_email_to_user
      true
    else
      false
    end
  end

  def send_confirmation_email_to_user
    NewUserConfirmation.user_confirmation(user).deliver unless user.confirmed
  end

end
