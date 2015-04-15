require 'rails_helper'

describe UserAuthenticator do

  let(:user) { create_user_with_encrypted_password(:user) }

  it 'responds to call messagem' do
    expect(UserAuthenticator).to respond_to(:call)
  end

  context 'returns' do
    it '{ user: nil, error: E-mail inváliado } when e-mail is INVALID' do
      email = "INVALID"
      password = "INVALID"
      expect(UserAuthenticator.call(email, password)).to eq({ user: nil, error: "E-mail não cadastrado"})
    end

    it '{ user: user, error: Usuário não confirmou e-mail } when confirmed is false' do
      user = create(:user)
      email = user.email
      password = "s3cr37"
      expect(UserAuthenticator.call(email, password)).to eq({ user: user, error: "Usuário não confirmou e-mail" })
    end

    it '{ user: user, error: Senha incorreta } when password is incorrect' do
      email = user.email
      password = "INVALID"
      expect(UserAuthenticator.call(email, password)).to eq({ user: user, error: "Senha incorreta" })
    end

    it '{ user: user, error: } when user authenticates' do
      email = user.email
      password = "s3cr37"
      expect(UserAuthenticator.call(email, password)).to eq({ user: user, error: "" })
    end
  end

end
