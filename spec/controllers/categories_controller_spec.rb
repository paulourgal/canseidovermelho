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

    it "get /categories/:id/edit to action edit" do
      expect(get: "categories/:id/edit").to route_to(
        controller: "categories", action: "edit", id: ":id"
      )
    end

    it "put /categories/:id to action update" do
      expect(put: "categories/:id").to route_to(
        controller: "categories", action: "update", id: ":id"
      )
    end

    it "delete /categories/:id to action destroy" do
      expect(delete: "categories/:id").to route_to(
        controller: "categories", action: "destroy", id: ":id"
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

  context '#edit' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        get :edit, id: 1
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @category = create(:category, user: user)
        sign_in(user)
        get :edit, id: @category.id
      end

      render_views

      it 'renders template edit' do
        expect(response).to render_template(:edit)
      end

      it 'assigns category' do
        expect(assigns(:category)).to eq(@category)
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

  context '#update' do

    context 'with unauthenticated user' do

      it 'redirects to login' do
        put :update, id: 1, category: { user_id: nil }
        expect(response).to redirect_to(root_url)
      end

    end

    context 'with authenticated user' do

      before(:each) do
        @category = create(:category, user: user)
        sign_in(user)
      end

      context 'and success' do

        it 'redirects to :edit' do
          put :update, id: @category.id, category: {
            kind: @category.kind, name: @category.name, user_id: @category.user_id
          }
          expect(response).to redirect_to(action: :edit)
        end

        it 'changes category attribute' do
          put :update, id: @category.id, category: {
            kind: @category.kind, name: "Nova Categoria", user_id: @category.user_id
          }
          @category.reload
          expect(@category.name).to eq("Nova Categoria")
        end

      end

      context 'and fails' do

        it 'renders template edit' do
          put :update, id: @category.id, category: {
            kind: nil, name: @category.name, user_id: @category.user_id
          }
          expect(response).to render_template(:edit)
        end

        it 'does not update category attribute' do
          put :update, id: @category.id, category: {
            kind: @category.kind, name: "Nova Categoria", user_id: @category.user_id
          }
          @category.reload
          expect(@category.name).not_to eq("Novo Categoria")
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
        @category = create(:category, user: user)
        sign_in(user)
      end

      it 'redirects to :index' do
        delete :destroy, id: @category.id
        expect(response).to redirect_to(action: :index)
      end

      it 'decreases Category' do
        expect do
          delete :destroy, id: @category.id
        end.to change(Category, :count).by(-1)
      end

    end

  end

end
