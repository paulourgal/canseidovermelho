require 'rails_helper'

describe UsersController do

  render_views

  context '#index' do

    context 'unauthenticated users' do

      it 'redirect_to sign_up' do
        get :index
        expect(response).to redirect_to(sign_up_url)
      end

    end

    context 'authenticated users' do
      before(:each) do
        user = create_user_with_encrypted_password(:user)
        sign_in(user)
        get :index
      end

      it 'redirect_to index template' do
        expect(response).to render_template(:index)
      end

      it 'assigns @users' do
        expect(assigns(:users)).to eq(User.all)
      end
    end

  end

  context '#new' do

    before(:each) { get :new }

    it 'renders new template' do
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
      userCreate = double(UserCreator)
      userCreate.stub(:call).with(anything()) { true }
      post :create, user: attributes_for(:user)
      expect(response).to redirect_to(root_url)
    end

    it 'render new when UserCreator.call returns false' do
      post :create, user: attributes_for(:user, :invalid)
      expect(response).to render_template(:new)
    end

  end

  context '#confirmation' do

    let(:user) { create(:user) }

    it 'must confirmed user' do
      get :confirmation, id: user
      user.reload
      expect(user.confirmed).to be_truthy
    end

    it 'must redirect to root_url' do
      get :confirmation, id: user
      expect(response).to redirect_to(root_url)
    end

  end

end
