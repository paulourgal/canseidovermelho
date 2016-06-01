class AddStatusToItems < ActiveRecord::Migration
  def up
    add_column :items, :status, :integer
  end

  def down
    remove_column :items, :status
  end
end
