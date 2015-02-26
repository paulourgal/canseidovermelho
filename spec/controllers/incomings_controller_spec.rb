require 'rails_helper'

describe IncomingsController do

  context "#index" do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        get :index
        expect(response).to redirect_to(log_in_path)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        sign_in(@user)
      end

      render_views

      it 'render index' do
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
        expect(response).to redirect_to(log_in_path)
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

      it 'assigns incoming' do
        expect(assigns(:incoming)).to be_a_new(Incoming)
      end

    end

  end

  context '#create' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        post :create,
          incoming: { day: Date.today, kind: 1, value: 100, user_id: 1 }
        expect(response).to redirect_to(log_in_path)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @user = create_user_with_encrypted_password(:user)
        sign_in(@user)
      end

      render_views

      context 'and success' do

        it 'creates a Incoming' do
          expect do
            post :create, incoming: {
              day: Date.today, kind: 1, value: 100, user_id: @user
            }
          end.to change(Incoming, :count).by(1)
        end

        it 'redirects to :index' do
          post :create, incoming: {
            day: Date.today, kind: 1, value: 100, user_id: @user
          }
          expect(response).to redirect_to(action: :index)
        end

      end

      context 'and falied' do

        it 'creates a Incoming' do
          expect do
            post :create, incoming: {
              day: Date.today, kind: 1, value: 100, user_id: nil
            }
          end.to change(Incoming, :count).by(0)
        end

        it 'render template new' do
          post :create, incoming: {
            day: Date.today, kind: 1, value: 100, user_id: nil
          }
          expect(response).to render_template(:new)
        end

      end

    end

  end

end
