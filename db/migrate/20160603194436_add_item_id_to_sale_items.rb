class AddItemIdToSaleItems < ActiveRecord::Migration
  def up
    add_column :sale_items, :item_id, :integer
  end

  def down
    remove_column :sale_items, :item_id
  end
end
