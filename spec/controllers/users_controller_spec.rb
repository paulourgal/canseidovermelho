require 'rails_helper'

describe UsersController do

  render_views

  context '#index' do

    before(:each) do
      create(:user)
      get :index
    end

    it 'redirect_to index template' do
      expect(response).to render_template(:index)
    end

    it 'assigns @users' do
      expect(assigns(:users)).to eq(User.all)
    end

  end

  context '#new' do

    before(:each) { get :new }

    it 'redirect_to new template' do
      expect(response).to render_template(:new)
    end

    it 'assigns @user' do
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  context '#create' do

    it 'sends call message to UserCreator' do
      expect(UserCreator).to receive(:call)
      post :create, user: attributes_for(:user)
    end

    it 'redirect_to new when UserCreator.call returns true' do
      post :create, user: attributes_for(:user)
      expect(response).to redirect_to(action: :index)
    end

    it 'render new when UserCreator.call returns false' do
      post :create, user: attributes_for(:user, :invalid)
      expect(response).to render_template(:new)
    end

  end

end