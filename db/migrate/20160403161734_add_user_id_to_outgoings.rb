class AddUserIdToOutgoings < ActiveRecord::Migration
  def up
    add_column :outgoings, :user_id, :integer
  end

  def down
    remove_column :outgoings, :user_id
  end
end
