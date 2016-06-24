class SellItems

  def self.call(sale)
    self.new(sale).call
  end

  attr_reader :sale

  def initialize(sale)
    @sale = sale
  end

  def call
    if sale.save
      sale.sale_items.each { |sale_item| update_item_quantity(sale_item) }
      true
    else
      false
    end
  end

  private

  def update_item_quantity(sale_item)
    item = sale_item.item
    quantity = sale_item.quantity
    item.quantity -= quantity
    item.save!
  end

end
