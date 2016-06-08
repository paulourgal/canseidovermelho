require 'rails_helper'

describe IncomingsController do

  context "routes" do

    it "get /incomings to action index" do
      expect(get: "incomings").to route_to(
        controller: "incomings", action: "index"
      )
    end

    it "get /incomings/new to action new" do
      expect(get: "incomings/new").to route_to(
        controller: "incomings", action: "new"
      )
    end

    it "post /incomings to action create" do
      expect(post: "incomings").to route_to(
        controller: "incomings", action: "create"
      )
    end

    it "get /incomings/:id/edit to action edit" do
      expect(get: "incomings/:id/edit").to route_to(
        controller: "incomings", action: "edit", id: ":id"
      )
    end

    it "put /incomings/:id to action update" do
      expect(put: "incomings/:id").to route_to(
        controller: "incomings", action: "update", id: ":id"
      )
    end

    it "delete /incomings/:id to action destroy" do
      expect(delete: "incomings/:id").to route_to(
        controller: "incomings", action: "destroy", id: ":id"
      )
    end

  end

  context "#index" do

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

      it 'assigns incomings' do
        create(:incoming)
        incomings = create_list(:incoming, 2, user: @user)
        get :index
        expect(assigns(:incomings)).to match_array(incomings)
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
        @categories = create_list(:category, 2, user: @user, kind: :incoming)
        get :new
      end

      render_views

      it 'renders template new' do
        expect(response).to render_template(:new)
      end

      it 'assigns incoming' do
        expect(assigns(:incoming)).to be_a_new(Incoming)
      end

      it 'assigns categories for user' do
        create(:category, user: @user, kind: :outgoing)
        create(:category, kind: :incoming)
        expect(assigns(:categories)).to match_array(@categories)
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
        @incoming = create(:incoming, user: @user)
        sign_in(@user)
        @categories = create_list(:category, 2, user: @user, kind: :incoming)
        get :edit, id: @incoming.id
      end

      render_views

      it 'renders template edit' do
        expect(response).to render_template(:edit)
      end

      it 'assigns incoming' do
        expect(assigns(:incoming)).to eq(@incoming)
      end

      it 'assigns categories for user' do
        create(:category, user: @user, kind: :outgoing)
        create(:category, kind: :incoming)
        expect(assigns(:categories)).to match_array(@categories)
      end

    end

  end

  context '#create' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        post :create,
          incoming: { day: Date.today, kind: :salary, value: 100, user_id: 1 }
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        sign_in(@user)
        @categories = create_list(:category, 2, user: @user, kind: :incoming)
      end

      render_views

      context 'and success' do

        it 'creates an Incoming' do
          expect do
            post :create, incoming: {
              category_id: @categories.first, day: Date.today, value: 100, user_id: @user
            }
          end.to change(Incoming, :count).by(1)
        end

        it 'redirects to :index' do
          post :create, incoming: {
            category_id: @categories.first, day: Date.today, value: 100, user_id: @user
          }
          expect(response).to redirect_to(action: :index)
        end

      end

      context 'and fails' do

        it 'does not create an Incoming' do
          expect do
            post :create, incoming: { user_id: nil }
          end.to change(Incoming, :count).by(0)
        end

        it 'render template new when fails' do
          post :create, incoming: { user_id: nil }
          expect(response).to render_template(:new)
        end

        it 'assigns categories for user' do
          create(:category, user: @user, kind: :outgoing)
          post :create, incoming: { user_id: nil }
          expect(assigns(:categories)).to match_array(@categories)
        end

      end

    end

  end

  context '#update' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        put :update, id: 1, incoming: { user_id: nil }
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        @incoming = create(:incoming, user: @user)
        sign_in(@user)
        @categories = create_list(:category, 2, user: @user, kind: :incoming)
      end

      context 'and success' do

        it 'redirects to :edit' do
          put :update, id: @incoming.id, incoming: {
            category_id: @incoming.category_id, day: @incoming.day,
            value: @incoming.value, user_id: @incoming.user_id
          }
          expect(response).to redirect_to(action: :edit)
        end

        it 'changes incoming attribute' do
          put :update, id: @incoming.id, incoming: {
            category_id: @incoming.category_id, day: Date.tomorrow,
            value: @incoming.value, user_id: @incoming.user_id
          }
          @incoming.reload
          expect(@incoming.day).to eq(Date.tomorrow)
        end

      end

      context 'and fails' do

        it 'renders template edit' do
          put :update, id: @incoming.id, incoming: {
            category_id: nil, day: @incoming.day, value: @incoming.value, user_id: @incoming.user_id
          }
          expect(response).to render_template(:edit)
        end

        it 'does not update incoming attribute' do
          put :update, id: @incoming.id, incoming: {
            category_id: nil, day: Date.tomorrow, value: @incoming.value, user_id: @incoming.user_id
          }
          @incoming.reload
          expect(@incoming.day).not_to eq(Date.tomorrow)
        end

        it 'assigns categories for user' do
          create(:category, user: @user, kind: :outgoing)
          put :update, id: @incoming.id, incoming: {
            category_id: nil, day: Date.tomorrow, value: @incoming.value, user_id: @incoming.user_id
          }
          expect(assigns(:categories)).to match_array(@categories)
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
        @incoming = create(:incoming, user: @user)
        sign_in(@user)
      end

      it 'redirects to :index' do
        delete :destroy, id: @incoming.id
        expect(response).to redirect_to(action: :index)
      end

      it 'decreases Incoming' do
        expect do
          delete :destroy, id: @incoming.id
        end.to change(Incoming, :count).by(-1)
      end

    end

  end

end
