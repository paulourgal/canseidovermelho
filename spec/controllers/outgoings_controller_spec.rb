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
          get :new
        end

        render_views

        it 'renders template new' do
          expect(response).to render_template(:new)
        end

        it 'assigns outgoing' do
          expect(assigns(:outgoing)).to be_a_new(Outgoing)
        end

      end

    end

  end

  context '#create' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        post :create,
          outgoing: { day: Date.today, kind: :feeding, value: 100, user_id: 1 }
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

        it 'creates a Outgoing' do
          expect do
            post :create, outgoing: {
              day: Date.today, kind: :feeding, value: 100, user_id: @user
            }
          end.to change(Outgoing, :count).by(1)
        end

        it 'redirects to :index' do
          post :create, outgoing: {
            day: Date.today, kind: :feeding, value: 100, user_id: @user
          }
          expect(response).to redirect_to(action: :index)
        end

      end

      context 'fails when' do

        it 'user is not present' do
          expect do
            post :create, outgoing: {
              day: Date.today, kind: :feeding, value: 100, user_id: nil
            }
          end.to change(Outgoing, :count).by(0)
        end

        it 'day is not present' do
          expect do
            post :create, outgoing: {
              day: nil, kind: :feeding, value: 100, user_id: @user
            }
          end.to change(Outgoing, :count).by(0)
        end

        it 'kind is not present' do
          expect do
            post :create, outgoing: {
              day: Date.today, kind: nil, value: 100, user_id: @user
            }
          end.to change(Outgoing, :count).by(0)
        end

        it 'value is not present' do
          expect do
            post :create, outgoing: {
              day: Date.today, kind: :feeding, value: nil, user_id: @user
            }
          end.to change(Outgoing, :count).by(0)
        end

      end

      it 'render template new when fails' do
        post :create, outgoing: {
          day: Date.today, kind: :feeding, value: 100, user_id: nil
        }
        expect(response).to render_template(:new)
      end

    end

  end

end
