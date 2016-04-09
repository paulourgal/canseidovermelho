require 'rails_helper'

describe Outgoing do

  let(:outgoing) { build(:outgoing) }

  it 'has a valid factory' do
    expect(build(:outgoing)).to be_valid
  end

  context 'belongs_to' do

    it 'user' do
      expect(outgoing).to belong_to(:user)
    end

  end

  context 'validates' do

    context 'presence of' do

      it 'day' do
        expect(outgoing).to validate_presence_of(:day)
      end

      it 'kind' do
        expect(outgoing).to validate_presence_of(:kind)
      end

      it 'user_id' do
        expect(outgoing).to validate_presence_of(:user_id)
      end

      it 'value' do
        expect(outgoing).to validate_presence_of(:value)
      end

    end

  end

  context 'scopes' do

    context 'by_user' do

      it 'must receive a @user as parameter' do
        expect { Outgoing.by_user }.to raise_error(ArgumentError)
      end

      context 'returns' do

        before(:each) { @user = create(:user) }

        it 'a empty array when there are not outgoings' do
          expect(Outgoing.by_user(@user)).to eq([])
        end

        it 'a empty array when user is nil' do
          expect(Outgoing.by_user(nil)).to eq([])
        end

        it 'a array of outgoings for user when there are not outgoings' do
          create(:outgoing)
          outgoings = create_list(:outgoing, 2, user: @user)
          expect(Outgoing.by_user(@user)).to match_array(outgoings)
        end

      end

    end

  end

end
