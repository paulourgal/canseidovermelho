class AddClientIdToSales < ActiveRecord::Migration
  def up
    add_column :sales, :client_id, :integer
  end

  def down
    remove_column :sales, :client_id
  end
end
