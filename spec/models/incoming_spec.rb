require 'rails_helper'

describe Incoming do

  let(:incoming) { build(:incoming) }

  it 'has a valid factory' do
    expect(build(:incoming)).to be_valid
  end

  context 'belongs_to' do

    it 'category' do
      expect(incoming).to belong_to(:category)
    end

    it 'user' do
      expect(incoming).to belong_to(:user)
    end

  end

  context 'delegations' do

    it 'name to category with prefix' do
      expect(incoming).to respond_to(:category_name)
    end

  end

  context 'validates' do

    context 'presence of' do

      it 'category_id' do
        expect(incoming).to validate_presence_of(:category_id)
      end

      it 'day' do
        expect(incoming).to validate_presence_of(:day)
      end

      it 'user_id' do
        expect(incoming).to validate_presence_of(:user_id)
      end

      it 'value' do
        expect(incoming).to validate_presence_of(:value)
      end

    end

  end

  context 'scopes' do

    context 'by_user' do

      it 'must receive a @user as parameter' do
        expect { Incoming.by_user }.to raise_error(ArgumentError)
      end

      context 'returns' do

        before(:each) { @user = create(:user) }

        it 'a empty array when there are not incomings' do
          expect(Incoming.by_user(@user)).to eq([])
        end

        it 'a empty array when user is nil' do
          expect(Incoming.by_user(nil)).to eq([])
        end

        it 'a array of incomings for user when there are not incomings' do
          create(:incoming)
          incomings = create_list(:incoming, 2, user: @user)
          expect(Incoming.by_user(@user)).to match_array(incomings)
        end

      end

    end

  end

end
