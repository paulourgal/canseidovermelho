require 'rails_helper'

describe SaleItem do

  let(:sale_item) { build(:sale_item) }

  it 'has a valid factory' do
    expect(build(:sale_item)).to be_valid
  end

  context 'belongs_to' do

    it 'item' do
      expect(sale_item).to belong_to(:item)
    end

    it 'sale' do
      expect(sale_item).to belong_to(:sale)
    end

  end

  context 'validates' do

    it 'presence of item_id' do
      expect(sale_item).to validate_presence_of(:item_id)
    end

    it 'presence of price' do
      expect(sale_item).to validate_presence_of(:price)
    end

  end

end
