class AddQuantityToSaleItems < ActiveRecord::Migration
  def up
    add_column :sale_items, :quantity, :integer
  end

  def down
    remove_column :sale_items, :quantity
  end
end
