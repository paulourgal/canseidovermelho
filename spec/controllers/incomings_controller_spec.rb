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
        get :index
      end

      render_views

      it 'render index' do
        expect(response).to render_template(:index)
      end

      it 'assigns incomings' do
        create(:incoming)
        incomings = create_list(:incoming, 2, user: @user)
        expect(assigns(:incomings)).to match_array(incomings)
      end

    end

  end

end
