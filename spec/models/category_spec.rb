require 'rails_helper'

describe Category do

  let(:category) { build(:category) }

  it 'has a valid factory' do
    expect(build(:category)).to be_valid
  end

  context 'belongs_to' do

    it 'user' do
      expect(category).to belong_to(:user)
    end

  end

  context 'validates' do

    it 'presence of user_id' do
      expect(category).to validate_presence_of(:user_id)
    end

    it 'presence of name' do
      expect(category).to validate_presence_of(:name)
    end

    it 'presence of kind' do
      expect(category).to validate_presence_of(:kind)
    end

  end

  context 'scopes' do

    context 'by_user' do

      it 'must receive a @user as parameter' do
        expect { Category.by_user }.to raise_error(ArgumentError)
      end

      context 'returns' do

        before(:each) { @user = create(:user) }

        it 'a empty array when there are not categories' do
          expect(Category.by_user(@user)).to eq([])
        end

        it 'a empty array when user is nil' do
          expect(Category.by_user(nil)).to eq([])
        end

        it 'a array of categories for user when there are categories' do
          create(:category)
          categories = create_list(:category, 2, user: @user)
          expect(Category.by_user(@user)).to match_array(categories)
        end

      end

    end

    context 'by_user_and_kind' do

      it 'must receive a @user and @kind as parameter' do
        expect { Category.by_user_and_kind }.to raise_error(ArgumentError)
      end

      context 'returns' do

        before(:each) { @user = create(:user) }

        it 'a empty array when there are not categories' do
          expect(Category.by_user_and_kind(@user, Category.kinds[:incoming])).to eq([])
        end

        it 'a empty array when user or kind is nil' do
          expect(Category.by_user_and_kind(nil, Category.kinds[:incoming])).to eq([])
          expect(Category.by_user_and_kind(@user, nil)).to eq([])
        end

        it 'a array of categories for user when there are categories' do
          create(:category)
          categories = create_list(:category, 2, user: @user, kind: :incoming)
          expect(Category.by_user_and_kind(@user, Category.kinds[:incoming]))
            .to match_array(categories)
        end

      end

    end

  end

end
