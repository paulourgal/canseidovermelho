require 'rails_helper'

describe ItemsController do

  context "routes" do

    it "get /items to action index" do
      expect(get: "items").to route_to(
        controller: "items", action: "index"
      )
    end

    it "get /items/new to action new" do
      expect(get: "items/new").to route_to(
        controller: "items", action: "new"
      )
    end

    it "post /items to action create" do
      expect(post: "items").to route_to(
        controller: "items", action: "create"
      )
    end

  end

  context '#index' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        get :index
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        sign_in(@user)
      end

      render_views

      it 'renders index' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns items' do
        create(:item)
        items = create_list(:item, 2, user: @user)
        get :index
        expect(assigns(:items)).to match_array(items)
      end

    end

  end

  context '#new' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        get :new
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        sign_in(@user)
        get :new
      end

      render_views

      it 'renders template new' do
        expect(response).to render_template(:new)
      end

      it 'assigns item' do
        expect(assigns(:item)).to be_a_new(Item)
      end

    end

  end

  context '#create' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        post :create, item: { user_id: 1 }
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        sign_in(@user)
        @category = create(:category, user: @user)
      end

      render_views

      context 'and success' do

        it 'creates an Item' do
          expect do
            post :create, item: { user_id: @user }
          end.to change(Item, :count).by(1)
        end

        it 'redirects to :index' do
          post :create, item: { user_id: @user }
          expect(response).to redirect_to(action: :index)
        end

      end

      context 'and fails' do

        it 'does not create an item' do
          expect do
            post :create, item: { user_id: nil }
          end.to change(Item, :count).by(0)
        end

        it 'render template new when fails' do
          post :create, item: { user_id: nil }
          expect(response).to render_template(:new)
        end

      end

    end

  end

end
