require 'rails_helper'

describe UserAuthenticator do

  let(:user) { create_user_with_encrypted_password(:user) }

  it 'responds to call messagem' do
    expect(UserAuthenticator).to respond_to(:call)
  end

  it 'returns nil when user not authenticate' do
    email = user.email
    password = "invalid"
    expect(UserAuthenticator.call(email, password)).to be_nil
  end

  it 'returns user when user authenticates' do
    email = user.email
    password = "s3cr37"
    expect(UserAuthenticator.call(email, password)).to eq(user)
  end

end
