class AddUserIdToSales < ActiveRecord::Migration
  def up
    add_column :sales, :user_id, :integer
  end

  def down
    remove_column :sales, :user_id
  end
end
