class AddSaleIdToSaleItems < ActiveRecord::Migration
  def up
    add_column :sale_items, :sale_id, :integer
  end

  def down
    remove_column :sale_items, :sale_id
  end
end
