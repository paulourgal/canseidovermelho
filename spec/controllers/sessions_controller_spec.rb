require 'rails_helper'

describe SessionsController do

  let(:user) { create_user_with_encrypted_password(:user) }

  context '#create' do

    it 'sends call to UserAuthenticator' do
      expect(UserAuthenticator).to receive(:call) { { user: nil,  error: "ERROR" } }
      post :create, email: "test@example.com", password: "s3cr37"
    end

    it 'sets cookies[:auth_token]' do
      post :create, email: user.email, password: user.password
      expect(cookies[:auth_token]).to eq(user.auth_token)
    end

    it 'redirects to sales_path when user autheticates' do
      post :create, email: user.email, password: user.password
      expect(response).to redirect_to(sales_path)
    end

    it 'redirects to root_url when user not autheticate' do
      post :create, email: "test@example.com", password: "s3cr37"
      expect(response).to redirect_to(root_url)
    end

  end

  context '#destroy' do

    before(:each) do
      post :create, email: user.email, password: user.password
      delete :destroy
    end

    it 'deleted cookies[:auth_token]' do
      expect(cookies[:auth_token]).to be_nil
    end

    it 'redirects to root_url' do
      expect(response).to redirect_to(root_url)
    end

  end

end
