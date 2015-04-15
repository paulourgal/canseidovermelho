require 'rails_helper'

describe PasswordGenerator do

  let(:user) { build(:user) }

  it 'responds to call message' do
    expect(PasswordGenerator).to respond_to(:call)
  end

  context 'returns nil when' do

    it 'when password is nil' do
      user = build(:user, password: nil)
      expect(PasswordGenerator.call(user)).to eq(nil)
    end

  end

  it 'returns user' do
    expect(PasswordGenerator.call(user)).to eq(user)
  end

  it 'generates the password_salt' do
    expect(PasswordGenerator.call(user).password_salt).not_to be_nil
  end

  it 'generates the password_hash' do
    expect(PasswordGenerator.call(user).password_hash).not_to be_nil
  end

end
