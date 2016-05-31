require 'rails_helper'

describe Item do

  let(:item) { build(:item) }

  it 'has a valid factory' do
    expect(build(:item)).to be_valid
  end

  context 'belongs_to' do

    it "user" do
      expect(item).to belong_to(:user)
    end

  end

  context 'validates' do

    it 'presence of user_id' do
      expect(item).to validate_presence_of(:user_id)
    end

  end

  context 'scopes' do

    context 'by_user' do

      it 'must receive a @user as parameter' do
        expect { Item.by_user }.to raise_error(ArgumentError)
      end

      context 'returns' do

        before(:each) { @user = create(:user) }

        it 'a empty array when there are not items' do
          expect(Item.by_user(@user)).to eq([])
        end

        it 'a empty array when user is nil' do
          expect(Item.by_user(nil)).to eq([])
        end

        it 'a array of items for user when there are not items' do
          create(:item)
          items = create_list(:item, 2, user: @user)
          expect(Item.by_user(@user)).to match_array(items)
        end

      end

    end

  end

end
