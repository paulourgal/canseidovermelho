class AddPriceToSaleItems < ActiveRecord::Migration
  def up
    add_column :sale_items, :price, :decimal
  end

  def down
    remove_column :sale_items, :price
  end
end
