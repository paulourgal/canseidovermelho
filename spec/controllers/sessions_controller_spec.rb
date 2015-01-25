require 'rails_helper'

describe SessionsController do

  render_views

  context '#new' do

    it 'render template new' do
      get :new
      expect(response).to render_template(:new)
    end

  end

  context '#create' do

    it 'sends call to UserAuthenticator' do
      expect(UserAuthenticator).to receive(:call)
      post :create, email: "test@example.com", password: "s3cr37"
    end

    it 'redirects to root_url when user autheticates' do
      UserCreator.call(build(:user))
      post :create, email: "test@example.com", password: "s3cr37"
      expect(response).to redirect_to(root_url)
    end

    it 'renders new when user not autheticate' do
      post :create, email: "test@example.com", password: "s3cr37"
      expect(response).to render_template(:new)
    end

  end

end
