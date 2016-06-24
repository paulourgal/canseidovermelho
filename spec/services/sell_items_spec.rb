require 'rails_helper'

describe SellItems do

  let(:sale) { build(:sale) }
  let(:invalid_sale) { build(:sale, client: nil) }

  context 'with valid sale' do

    it 'returns true' do
      expect(SellItems.call(sale)).to be_truthy
    end

    it 'creates a new Sale' do
      expect { SellItems.call(sale) }.to change(Sale, :count).by(1)
    end

    it 'updates Items quantity' do
      item = create(:item, quantity: 10)
      sale.sale_items.build(item_id: item.id, price: 10, quantity: 5)
      SellItems.call(sale)
      item.reload
      expect(item.quantity).to eq(5)
    end

  end

  context 'with invalid sale' do

    it 'returns false' do
      expect(SellItems.call(invalid_sale)).to be_falsy
    end

    it 'does not create a new Sale' do
      expect { SellItems.call(invalid_sale) }.not_to change(Sale, :count)
    end

    it 'does not update Items quantity' do
      item = create(:item, quantity: 10)
      invalid_sale.sale_items.build(item_id: item.id, price: 10, quantity: 5)
      SellItems.call(invalid_sale)
      item.reload
      expect(item.quantity).to eq(10)
    end

  end

end
