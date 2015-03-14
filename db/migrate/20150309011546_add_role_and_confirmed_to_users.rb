class AddRoleAndConfirmedToUsers < ActiveRecord::Migration
  def up
    add_column :users, :role, :integer
    add_column :users, :confirmed, :boolean
  end

  def down
    remove_column :users, :role
    remove_column :users, :confirmed
  end
end
