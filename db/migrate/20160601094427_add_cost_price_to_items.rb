class AddCostPriceToItems < ActiveRecord::Migration
  def up
    add_column :items, :cost_price, :decimal
  end

  def down
    remove_column :items, :cost_price
  end
end
