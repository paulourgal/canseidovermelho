require 'rails_helper'

describe User do

  let(:user) { build(:user) }

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  context 'validates' do

    context 'presence of' do

      [:birth_date, :email, :name, :role].each do |attr_sym|
        it attr_sym do
          expect(user).to validate_presence_of(attr_sym)
        end
      end

      context 'on create' do
        [:password, :password_confirmation].each do |attr_sym|
          it attr_sym do
            expect(user).to validate_presence_of(attr_sym).on(:create)
          end
        end
      end

    end

    it 'confirmation of password' do
      expect(user).to validate_confirmation_of(:password)
    end

    it 'uniqueness of email' do
      expect(user).to validate_uniqueness_of(:email)
    end

    context 'format of email' do

      it 'paulo@example must be invalid' do
        user.email = "paulo@example"
        user.valid?
        expect(user.errors[:email].size).to be > 0
      end

      it 'paulo@example.com must be valid' do
        user.email = "paulo@example.com"
        user.valid?
        expect(user.errors[:email].size).to eq(0)
      end

    end

    it 'confirmed included in [false, true]' do
      expect(user).to validate_inclusion_of(:confirmed).in_array([true, false])
    end
  end

end
