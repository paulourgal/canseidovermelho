require 'rails_helper'

describe Sale do

  let(:sale) { build(:sale) }

  it 'has a valid factory'  do
    expect(build(:sale)).to be_valid
  end

  context 'belongs_to' do

    it 'client' do
      expect(sale).to belong_to(:client)
    end

    it 'user' do
      expect(sale).to belong_to(:user)
    end

  end

  context 'delegations' do

    it 'name to client with prefix' do
      expect(sale).to respond_to(:client_name)
    end

  end

  context 'validates' do

    it 'presence_of client_id' do
      expect(sale).to validate_presence_of(:client_id)
    end

    it 'presence_of date' do
      expect(sale).to validate_presence_of(:date)
    end

    it 'presence_of user_id' do
      expect(sale).to validate_presence_of(:user_id)
    end

  end

  context 'scopes' do

    context 'by_user' do

      it 'must receive a @user as parameter' do
        expect { Sale.by_user }.to raise_error(ArgumentError)
      end

    end

    context 'returns' do

      before(:each) { @user = create(:user) }

      it 'a empty array when there are not clients' do
        expect(Sale.by_user(@user)).to eq([])
      end

      it 'a empty array when user is nil' do
        expect(Sale.by_user(nil)).to eq([])
      end

      it 'a array of clients for user when there are not clients' do
        create(:sale)
        sales = create_list(:sale, 2, user: @user)
        expect(Sale.by_user(@user)).to match_array(sales)
      end

    end

  end

end
