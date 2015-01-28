require 'rails_helper'

describe Incoming do

  let(:incoming) { build(:incoming) }

  it 'has a valid factory' do
    expect(build(:incoming)).to be_valid
  end

  context 'belongs_to' do

    it 'user' do
      expect(incoming).to belong_to(:user)
    end

  end

end
