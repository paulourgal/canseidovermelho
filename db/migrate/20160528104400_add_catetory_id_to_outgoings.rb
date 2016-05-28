class AddCatetoryIdToOutgoings < ActiveRecord::Migration
  def up
    add_column :outgoings, :category_id, :integer
  end

  def down
    remove_column :outgoings, :category_id
  end
end
