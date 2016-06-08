require 'rails_helper'

describe OutgoingsController do

  context "routes" do

    it "get /outgoings to action index" do
      expect(get: "outgoings").to route_to(
        controller: "outgoings", action: "index"
      )
    end

    it "get /outgoings/new to action new" do
      expect(get: "outgoings/new").to route_to(
        controller: "outgoings", action: "new"
      )
    end

    it "post /outgoings to action create" do
      expect(post: "outgoings").to route_to(
        controller: "outgoings", action: "create"
      )
    end

    it "get /outgoings/:id/edit to action edit" do
      expect(get: "outgoings/:id/edit").to route_to(
        controller: "outgoings", action: "edit", id: ":id"
      )
    end

    it "put /outgoings/:id to action update" do
      expect(put: "outgoings/:id").to route_to(
        controller: "outgoings", action: "update", id: ":id"
      )
    end

    it "delete /outgoings/:id to action destroy" do
      expect(delete: "outgoings/:id").to route_to(
        controller: "outgoings", action: "destroy", id: ":id"
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

      it 'sends by_user message to Outgoing' do
        expect(Outgoing).to receive(:by_user).with(@user) { [] }
        get :index
      end

      it 'assigns outgoing' do
        create(:outgoing)
        outgoings = create_list(:outgoing, 2, user: @user)
        get :index
        expect(assigns(:outgoings)).to match_array(outgoings)
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
          @categories = create_list(:category, 2, user: @user, kind: :outgoing)
          get :new
        end

        render_views

        it 'renders template new' do
          expect(response).to render_template(:new)
        end

        it 'assigns outgoing' do
          expect(assigns(:outgoing)).to be_a_new(Outgoing)
        end

        it 'assigns categories for user' do
          create(:category, user: @user, kind: :incoming)
          create(:category, kind: :outgoing)
          expect(assigns(:categories)).to match_array(@categories)
        end

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
        @outgoing = create(:outgoing, user: @user)
        sign_in(@user)
        @categories = create_list(:category, 2, user: @user, kind: :outgoing)
        get :edit, id: @outgoing.id
      end

      render_views

      it 'renders template edit' do
        expect(response).to render_template(:edit)
      end

      it 'assigns outgoing' do
        expect(assigns(:outgoing)).to eq(@outgoing)
      end

      it 'assigns categories for user' do
        create(:category, user: @user, kind: :incoming)
        create(:category, kind: :outgoing)
        expect(assigns(:categories)).to match_array(@categories)
      end

    end

  end

  context '#create' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        post :create,
          outgoing: { day: Date.today, value: 100, user_id: 1 }
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        sign_in(@user)
        @categories = create_list(:category, 2, user: @user, kind: :outgoing)
        @category = create(:category, user: @user)
      end

      render_views

      context 'and success' do

        it 'creates a Outgoing' do
          expect do
            post :create, outgoing: {
              category_id: @category, day: Date.today, value: 100, user_id: @user
            }
          end.to change(Outgoing, :count).by(1)
        end

        it 'redirects to :index' do
          post :create, outgoing: {
            category_id: @category, day: Date.today, value: 100, user_id: @user
          }
          expect(response).to redirect_to(action: :index)
        end

      end

      context 'and fails' do

        it 'does not create an Outgoing' do
          expect do
            post :create, outgoing: { day: Date.today, value: 100, user_id: nil }
          end.to change(Outgoing, :count).by(0)
        end

        it 'render template new when fails' do
          post :create, outgoing: { day: Date.today, value: 100, user_id: nil }
          expect(response).to render_template(:new)
        end

        it 'assigns categories for user' do
          create(:category, user: @user, kind: :incoming)
          post :create, outgoing: { day: Date.today, value: 100, user_id: nil }
          expect(assigns(:categories)).to match_array(@categories)
        end

      end

    end

  end

  context '#update' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        put :update, id: 1, outgoing: { user_id: nil }
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        @outgoing = create(:outgoing, user: @user)
        sign_in(@user)
        @categories = create_list(:category, 2, user: @user, kind: :outgoing)
      end

      context 'and success' do

        it 'redirects to :edit' do
          put :update, id: @outgoing.id, outgoing: {
            category_id: @outgoing.category_id, day: @outgoing.day,
            value: @outgoing.value, user_id: @outgoing.user_id
          }
          expect(response).to redirect_to(action: :edit)
        end

        it 'changes outgoing attribute' do
          put :update, id: @outgoing.id, outgoing: {
            category_id: @outgoing.category_id, day: Date.tomorrow,
            value: @outgoing.value, user_id: @outgoing.user_id
          }
          @outgoing.reload
          expect(@outgoing.day).to eq(Date.tomorrow)
        end

      end

      context 'and fails' do

        it 'renders template edit' do
          put :update, id: @outgoing.id, outgoing: {
            category_id: nil, day: @outgoing.day, value: @outgoing.value, user_id: @outgoing.user_id
          }
          expect(response).to render_template(:edit)
        end

        it 'does not update outgoing attribute' do
          put :update, id: @outgoing.id, outgoing: {
            category_id: nil, day: Date.tomorrow, value: @outgoing.value, user_id: @outgoing.user_id
          }
          @outgoing.reload
          expect(@outgoing.day).not_to eq(Date.tomorrow)
        end

        it 'assigns categories for user' do
          create(:category, user: @user, kind: :incoming)
          put :update, id: @outgoing.id, outgoing: {
            category_id: nil, day: Date.tomorrow, value: @outgoing.value, user_id: @outgoing.user_id
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
        @outgoing = create(:outgoing, user: @user)
        sign_in(@user)
      end

      it 'redirects to :index' do
        delete :destroy, id: @outgoing.id
        expect(response).to redirect_to(action: :index)
      end

      it 'decreases Outgoing' do
        expect do
          delete :destroy, id: @outgoing.id
        end.to change(Outgoing, :count).by(-1)
      end

    end

  end

end
