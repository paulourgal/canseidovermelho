class AddCategoryIdToIncomings < ActiveRecord::Migration
  def up
    add_column :incomings, :category_id, :integer
  end

  def down
    remove_column :incomings, :category_id
  end
end
