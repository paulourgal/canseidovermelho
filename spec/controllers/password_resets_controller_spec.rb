require 'rails_helper'

describe PasswordResetsController do

  let(:user) { create(:user, :confirmed) }

  render_views

  context '#new' do

    it 'renders new template' do
      get :new
      expect(response).to render_template(:new)
    end

  end

  context '#create' do

    it "sends 'call' message to PasswordResetter" do
      expect(PasswordResetter).to receive(:call) { { success: true, msg: "MSG" } }
      post :create, email: user.email
    end

    it 'when PasswordResetter return success must redirect to root_url' do
      post :create, email: user.email
      expect(response).to redirect_to(root_url)
    end

    it 'when PasswordResetter return fail must render new' do
      post :create, email: "INVALID"
      expect(response).to render_template(:new)
    end

  end

  context '#edit' do

    let(:user) { create_user_with_password_reset_token }

    it 'render edit template' do
      get :edit, id: user.password_reset_token
      expect(response).to render_template(:edit)
    end

    it 'assigns @user' do
      get :edit, id: user.password_reset_token
      expect(assigns(:user)).to eq(user)
    end

    context 'redirects to root_url when' do

      it 'password resets expire' do
        user.password_reset_sent_at = Time.now - 3.hour
        user.save!
        get :edit, id: user.password_reset_token
        expect(response).to redirect_to(root_url)
      end

      it 'password_reset_token is invalid' do
        get :edit, id: "INVALID"
        expect(response).to redirect_to(root_url)
      end

    end

  end

  context '#update' do

    let(:user) { create_user_with_password_reset_token }

    context 'when password_reset_token is invalid' do

      it 'redirects to root_url' do
        put :update, id: "INVALID",
          user: { password: "NEWPASSWORD", password_confirmation: "NEWPASSWORD" }
        expect(response).to redirect_to(root_url)
      end

    end

    context 'when password_reset_token is valid' do

      context 'and was generated less then two hours before' do

        context 'and password and password_confirmation is valid' do

          it 'changes the user password_salt' do
            password_salt = user.password_salt
            put :update, id: user.password_reset_token,
              user: { password: "NEWPASSWORD", password_confirmation: "NEWPASSWORD" }
            user.reload
            expect(user.password_salt).not_to eq(password_salt)
          end

          it 'changes the user password_hash' do
            password_hash = user.password_hash
            put :update, id: user.password_reset_token,
              user: { password: "NEWPASSWORD", password_confirmation: "NEWPASSWORD" }
            user.reload
            expect(user.password_hash).not_to eq(password_hash)
          end

          it 'redirects to root_url' do
            put :update, id: user.password_reset_token,
              user: { password: "NEWPASSWORD", password_confirmation: "NEWPASSWORD" }
            expect(response).to redirect_to(root_url)
          end

        end

        context 'and password and password_confirmation is invalid' do

          it 'redirects to edit' do
            password_reset_token = user.password_reset_token
            put :update, id: user.password_reset_token,
              user: { password: "", password_confirmation: "" }
            expect(response).to redirect_to(edit_password_reset_path(password_reset_token))
          end

        end

      end

    end

  end

end
