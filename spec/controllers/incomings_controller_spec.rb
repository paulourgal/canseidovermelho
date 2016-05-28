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
        @category = create(:category, user: @user)
      end

      render_views

      context 'and success' do

        it 'creates an Incoming' do
          expect do
            post :create, incoming: {
              category_id: @category, day: Date.today, value: 100, user_id: @user
            }
          end.to change(Incoming, :count).by(1)
        end

        it 'redirects to :index' do
          post :create, incoming: {
            category_id: @category, day: Date.today, value: 100, user_id: @user
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

      end

    end

  end

end
