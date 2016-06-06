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

    it "get /items/:id/edit to action edit" do
      expect(get: "items/:id/edit").to route_to(
        controller: "items", action: "edit", id: ":id"
      )
    end

    it "put /items/:id to action update" do
      expect(put: "items/:id").to route_to(
        controller: "items", action: "update", id: ":id"
      )
    end

    it "delete /items/:id to action destroy" do
      expect(delete: "items/:id").to route_to(
        controller: "items", action: "destroy", id: ":id"
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

  context '#edit' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        get :edit, id: 1
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        @item = create(:item, user: @user)
        sign_in(@user)
        get :edit, id: @item.id
      end

      render_views

      it 'renders template edit' do
        expect(response).to render_template(:edit)
      end

      it 'assigns item' do
        expect(assigns(:item)).to eq(@item)
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
      end

      render_views

      context 'and success' do

        it 'creates an Item' do
          expect do
            post :create, item: {
              cost_price: 10, name: "Item", quantity: 1,
              status: :available, unitary_price: 10, user_id: @user
            }
          end.to change(Item, :count).by(1)
        end

        it 'redirects to :index' do
          post :create, item: {
            cost_price: 10, name: "Item", quantity: 1,
            status: :available, unitary_price: 10, user_id: @user
          }
          expect(response).to redirect_to(action: :index)
        end

      end

      context 'and fails' do

        it 'does not create an item' do
          expect do
            post :create, item: { user_id: nil }
          end.to change(Item, :count).by(0)
        end

        it 'render template new' do
          post :create, item: { user_id: nil }
          expect(response).to render_template(:new)
        end

      end

    end

  end

  context '#update' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        put :update, id: 1, item: { user_id: nil }
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        @item = create(:item, user: @user)
        sign_in(@user)
      end

      context 'and success' do

        it 'redirects to :edit' do
          put :update, id: @item.id, item: {
            cost_price: @item.cost_price, name: @item.name, quantity: @item.quantity,
            status: @item.status, unitary_price: @item.unitary_price, user_id: @item.user_id
          }
          expect(response).to redirect_to(action: :edit)
        end

        it 'changes item attribute' do
          put :update, id: @item.id, item: {
            cost_price: @item.cost_price, name: "Novo Nome", quantity: @item.quantity,
            status: @item.status, unitary_price: @item.unitary_price, user_id: @item.user_id
          }
          @item.reload
          expect(@item.name).to eq("Novo Nome")
        end

      end

      context 'and fails' do

        it 'renders template edit' do
          put :update, id: @item.id, item: {
            cost_price: nil, name: @item.name, quantity: @item.quantity,
            status: @item.status, unitary_price: @item.unitary_price, user_id: @item.user_id
          }
          expect(response).to render_template(:edit)
        end

        it 'does not update item attribute' do
          put :update, id: @item.id, item: {
            cost_price: nil, name: "Novo Nome", quantity: @item.quantity,
            status: @item.status, unitary_price: @item.unitary_price, user_id: @item.user_id
          }
          @item.reload
          expect(@item.name).not_to eq("Novo Nome")
        end

      end

    end

  end

  context '#destroy' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        delete :destroy, id: 1
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        @item = create(:item, user: @user)
        sign_in(@user)
      end

      it 'redirects to :index' do
        delete :destroy, id: @item.id
        expect(response).to redirect_to(action: :index)
      end

      it 'decreases Item' do
        expect do
          delete :destroy, id: @item.id
        end.to change(Item, :count).by(-1)
      end

    end

  end

end
