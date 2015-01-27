
def sign_in(user)
  user = UserAuthenticator.call(user.email, user.password)

  if user
    session[:user_id] = user.id
  end
end