require 'rails_helper'

describe UsersController do

  context '#index' do
    it 'exposes users' do
      create_list(:user, 2)
      get :index
      expect(assigns(:users)).to match_array(User.all)
    end

    context 'renders' do
      render_views

      it 'template index' do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

end
