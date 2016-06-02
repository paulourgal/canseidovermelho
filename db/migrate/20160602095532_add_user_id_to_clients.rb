class AddUserIdToClients < ActiveRecord::Migration
  def up
    add_column :clients, :user_id, :integer
  end

  def down
    remove_column :clients, :user_id
  end
end
