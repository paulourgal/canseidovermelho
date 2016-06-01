class AddUnitaryPriceToItems < ActiveRecord::Migration
  def up
    add_column :items, :unitary_price, :decimal
  end

  def down
    remove_column :items, :unitary_price
  end
end
