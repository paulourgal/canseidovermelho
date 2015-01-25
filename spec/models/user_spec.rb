require 'rails_helper'

describe User do

  let(:user) { build(:user) }

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  context 'validates' do

    context 'presence of' do

      [:email, :name, :birth_date].each do |attr_sym|
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
  end

end
