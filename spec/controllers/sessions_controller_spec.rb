require 'rails_helper'

describe SessionsController do

  context '#create' do

    it 'sends call to UserAuthenticator' do
      expect(UserAuthenticator).to receive(:call)
      post :create, email: "test@example.com", password: "s3cr37"
    end

    it 'redirects to incomings_path when user autheticates' do
      user = create_user_with_encrypted_password(:user)
      post :create, email: user.email, password: user.password
      expect(response).to redirect_to(incomings_path)
    end

    it 'redirects to root_url when user not autheticate' do
      post :create, email: "test@example.com", password: "s3cr37"
      expect(response).to redirect_to(root_url)
    end

  end

end
