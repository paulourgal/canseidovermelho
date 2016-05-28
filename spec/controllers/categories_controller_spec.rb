require 'rails_helper'

describe CategoriesController do

  let(:user) { create_user_with_encrypted_password(:user) }
  let(:invalid_category_attributes) { { user_id: nil } }
  let(:valid_category_attributes) do
    { kind: :incoming, name: "MyCategory", user_id: user }
  end

  context "routes" do

    it "get /categories to action index" do
      expect(get: "categories").to route_to(
        controller: "categories", action: "index"
      )
    end

    it "get /categories/new to action new" do
      expect(get: "categories/new").to route_to(
        controller: "categories", action: "new"
      )
    end

    it "post /categories to action create" do
      expect(post: "categories").to route_to(
        controller: "categories", action: "create"
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
        sign_in(user)
      end

      render_views

      it 'renders index' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns categories' do
        create(:category)
        categories = create_list(:category, 2, user: user)
        get :index
        expect(assigns(:categories)).to match_array(categories)
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
        sign_in(user)
        get :new
      end

      render_views

      it 'renders template new' do
        expect(response).to render_template(:new)
      end

      it 'assigns category' do
        expect(assigns(:category)).to be_a_new(Category)
      end

    end

  end

  context '#create' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        post :create, category: { user_id: 1 }
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        sign_in(user)
      end

      render_views

      context 'and success' do

        it 'creates a category' do
          expect do
            post :create, category: valid_category_attributes
          end.to change(Category, :count).by(1)
        end

        it 'redirects to :index' do
          post :create, category: valid_category_attributes
          expect(response).to redirect_to(action: :index)
        end

      end

      context 'and fails' do

        it 'does not create a category' do
          expect do
            post :create, category: invalid_category_attributes
          end.to change(Category, :count).by(0)
        end

        it 'render template new when fails' do
          post :create, category: invalid_category_attributes
          expect(response).to render_template(:new)
        end

      end

    end

  end

end
