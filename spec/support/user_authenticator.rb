def sign_in(user)
  result = UserAuthenticator.call(user.email, user.password)

  if result[:error].blank?
    cookies[:auth_token] = result[:user].auth_token
  end
end
