
def create_user_with_encrypted_password(user_factory, trait = nil)
  if trait
    user = build(user_factory, trait)
  else
    user = build(user_factory)
  end

  UserCreator.call(user)

  user
end