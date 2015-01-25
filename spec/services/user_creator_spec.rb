require 'rails_helper'

describe UserCreator do

  let(:invalid_user) { build(:user, :invalid) }
  let(:user)         { build(:user) }

  it 'responds to call message' do
    expect(UserCreator).to respond_to(:call)
  end

  context 'when user is invalid' do

    it 'returns false' do
      expect(UserCreator.call(invalid_user)).to be_falsy
    end

    it 'does not create a user' do
        expect do
          UserCreator.call(invalid_user)
        end.to change(User, :count).by(0)
    end
  end

  context 'when user is valid' do

    it 'returns true' do
      expect(UserCreator.call(user)).to be_truthy
    end

    it 'creates a user when is valid' do
      expect do
        UserCreator.call(user)
      end.to change(User, :count).by(1)
    end

  end

end
