def create_user_with_encrypted_password(user_factory, trait = :confirmed)
  user = build(user_factory, trait)
  UserCreator.call(user)
  user
end

def create_user_with_password_reset_token
  user = create_user_with_encrypted_password(:user)
  PasswordResetter.call(user.email)
  user.reload
end
