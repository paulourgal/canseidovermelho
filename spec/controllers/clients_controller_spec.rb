require 'rails_helper'

describe ClientsController do

  context "routes" do

    it "get /clients to action index" do
      expect(get: "clients").to route_to(controller: "clients", action: "index")
    end

    it 'get /clients/new to action new' do
      expect(get: "clients/new").to route_to(controller: "clients", action: "new")
    end

    it 'post /clients to action create' do
      expect(post: "clients").to route_to(controller: "clients", action: "create")
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

      it 'assigns clients' do
        create(:client)
        clients = create_list(:client, 2, user: @user)
        get :index
        expect(assigns(:clients)).to match_array(clients)
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

      it 'assigns client' do
        expect(assigns(:client)).to be_a_new(Client)
      end

    end

  end

  context '#create' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        post :create, client: { user_id: 1 }
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

        it 'creates an Client' do
          expect do
            post :create, client: {
              address: "Rua Teste", email: "email@example.com", name: "Client", phone: "99999999",
              observations: "TESTE", status: :active, user_id: @user
            }
          end.to change(Client, :count).by(1)
        end

        it 'redirects to :index' do
          post :create, client: {
            address: "Rua Teste", email: "email@example.com", name: "Client", phone: "99999999",
            observations: "TESTE", status: :active, user_id: @user
          }
          expect(response).to redirect_to(action: :index)
        end

      end

      context 'and fails' do

        it 'does not create an client' do
          expect do
            post :create, client: { user_id: nil }
          end.to change(Client, :count).by(0)
        end

        it 'render template new when fails' do
          post :create, client: { user_id: nil }
          expect(response).to render_template(:new)
        end

      end

    end

  end

end
