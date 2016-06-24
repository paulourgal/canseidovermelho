require 'rails_helper'

describe SalesController do

  context "routes" do

    it "get /sales to action index" do
      expect(get: "sales").to route_to(controller: "sales", action: "index")
    end

    it 'get /sales/new to action new' do
      expect(get: "sales/new").to route_to(controller: "sales", action: "new")
    end

    it 'post /sales to action create' do
      expect(post: "sales").to route_to(controller: "sales", action: "create")
    end

    it "get /sales/:id/edit to action edit" do
      expect(get: "sales/:id/edit").to route_to(
        controller: "sales", action: "edit", id: ":id"
      )
    end

    it "put /sales/:id to action update" do
      expect(put: "sales/:id").to route_to(
        controller: "sales", action: "update", id: ":id"
      )
    end

    it "delete /sales/:id to action destroy" do
      expect(delete: "sales/:id").to route_to(
        controller: "sales", action: "destroy", id: ":id"
      )
    end

  end

  context '#index' do

    context 'with unauthenticated user' do

      it 'redirects to login page' do
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

      it 'renders index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns sales' do
        create(:sale)
        sales = create_list(:sale, 2, user: @user)
        get :index
        expect(assigns(:sales)).to match_array(sales)
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
        create(:client)
        @clients = create_list(:client, 2, user: @user)
        @items = create_list(:item, 2, user: @user)
        sign_in(@user)
        get :new
      end

      render_views

      it 'renders template new' do
        expect(response).to render_template(:new)
      end

      it 'assigns sale' do
        expect(assigns(:sale)).to be_a_new(Sale)
      end

      it 'sale.sale_items.count == 1' do
        expect(assigns(:sale).sale_items.first).to be_a_kind_of(SaleItem)
      end

      it 'assigns clients' do
        expect(assigns(:clients)).to match_array(@clients)
      end

      it 'assigns items' do
        expect(assigns(:items)).to match_array(@items)
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
        @sale = create(:sale, user: @user)
        @clients = create_list(:client, 2, user: @user)
        @items = create_list(:item, 2, user: @user)
        sign_in(@user)
        get :edit, id: @sale.id
      end

      render_views

      it 'renders template edit' do
        expect(response).to render_template(:edit)
      end

      it 'assigns sale' do
        expect(assigns(:sale)).to eq(@sale)
      end

      it 'assigns clients' do
        expect(assigns(:clients)).to match_array(@clients)
      end

      it 'assigns items' do
        expect(assigns(:items)).to match_array(@items)
      end

    end

  end

  context '#create' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        post :create, sale: { user_id: 1 }
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        sign_in(@user)
      end

      it 'sends call message to SellItems service' do
        expect(SellItems).to receive(:call)
        client = create(:client, user: @user)
        item = create(:item, user: @user)
        post :create, sale: {
          client_id: client, date: Date.today, user_id: @user,
          sale_items_attributes: { '0' => { price: 10, quantity: 5, item_id: item } }
        }
      end

      render_views

      context 'and success' do

        it 'redirects to :index' do
          client = create(:client, user: @user)
          item = create(:item, user: @user)
          post :create, sale: {
            client_id: client, date: Date.today, user_id: @user,
            sale_items_attributes: { '0' => { price: 10, quantity: 5, item_id: item } }
          }
          expect(response).to redirect_to(action: :index)
        end

      end

      context 'and fails' do

        it 'render template new' do
          post :create, sale: { user_id: nil }
          expect(response).to render_template(:new)
        end

        it 'sale.sale_items.count == 1' do
          post :create, sale: { user_id: nil }
          expect(assigns(:sale).sale_items.first).to be_a_kind_of(SaleItem)
        end

        it 'assigns clients' do
          create(:client)
          clients = create_list(:client, 2, user: @user)
          post :create, sale: { user_id: nil }
          expect(assigns(:clients)).to match_array(clients)
        end

        it 'assigns items' do
          create(:item)
          items = create_list(:item, 2, user: @user)
          post :create, sale: { user_id: nil }
          expect(assigns(:items)).to match_array(items)
        end

      end

    end

  end

  context '#update' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        put :update, id: 1, sale: { user_id: nil }
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        @sale = create(:sale, user: @user)
        sign_in(@user)
      end

      context 'and success' do

        it 'redirects to :edit' do
          put :update, id: @sale.id, sale: {
            client_id: @sale.client_id, date: @sale.date, user_id: @sale.user_id
          }
          expect(response).to redirect_to(action: :edit)
        end

        it 'changes sale attribute' do
          put :update, id: @sale.id, sale: {
            client_id: @sale.client_id, date: Date.tomorrow, user_id: @sale.user_id
          }
          @sale.reload
          expect(@sale.date).to eq(Date.tomorrow)
        end

      end

      context 'and fails' do

        it 'renders template edit' do
          put :update, id: @sale.id, sale: {
            client_id: nil, date: Date.tomorrow, user_id: @sale.user_id
          }
          expect(response).to render_template(:edit)
        end

        it 'does not update sale attribute' do
          put :update, id: @sale.id, sale: {
            client_id: nil, date: Date.tomorrow, user_id: @sale.user_id
          }
          @sale.reload
          expect(@sale.date).not_to eq(Date.tomorrow)
        end

        it 'assigns clients' do
          create(:client)
          clients = create_list(:client, 2, user: @user)
          put :update, id: @sale.id, sale: {
            client_id: nil, date: Date.tomorrow, user_id: @sale.user_id
          }
          expect(assigns(:clients)).to match_array(clients)
        end

        it 'assigns items' do
          create(:item)
          items = create_list(:item, 2, user: @user)
          put :update, id: @sale.id, sale: {
            client_id: nil, date: Date.tomorrow, user_id: @sale.user_id
          }
          expect(assigns(:items)).to match_array(items)
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
        @sale = create(:sale, user: @user)
        sign_in(@user)
      end

      it 'redirects to :index' do
        delete :destroy, id: @sale.id
        expect(response).to redirect_to(action: :index)
      end

      it 'decreases Sale' do
        expect { delete :destroy, id: @sale.id }.to change(Sale, :count).by(-1)
      end

    end

  end

end
