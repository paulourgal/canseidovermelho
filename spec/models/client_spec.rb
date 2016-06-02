require 'rails_helper'

describe Client do

  let(:client) { build(:client) }

  it 'has a valid factory' do
    expect(build(:client)).to be_valid
  end

  context 'belongs_to' do

    it 'user' do
      expect(client).to belong_to(:user)
    end

  end

  context 'validates' do

    it 'presence of address' do
      expect(client).to validate_presence_of(:address)
    end

    it 'presence of name' do
      expect(client).to validate_presence_of(:name)
    end

    it 'presence of phone' do
      expect(client).to validate_presence_of(:phone)
    end

    it 'presence of status' do
      expect(client).to validate_presence_of(:status)
    end

    it 'presence of user_id' do
      expect(client).to validate_presence_of(:user_id)
    end

  end

  context 'scopes' do

    context 'by_user' do

      it 'must receive a @user as parameter' do
        expect { Client.by_user }.to raise_error(ArgumentError)
      end

      context 'returns' do

        before(:each) { @user = create(:user) }

        it 'a empty array when there are not clients' do
          expect(Client.by_user(@user)).to eq([])
        end

        it 'a empty array when user is nil' do
          expect(Client.by_user(nil)).to eq([])
        end

        it 'a array of clients for user when there are not clients' do
          create(:client)
          clients = create_list(:client, 2, user: @user)
          expect(Client.by_user(@user)).to match_array(clients)
        end

      end

    end

  end

end
