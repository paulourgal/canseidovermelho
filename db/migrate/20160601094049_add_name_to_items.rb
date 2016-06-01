class AddNameToItems < ActiveRecord::Migration
  def up
    add_column :items, :name, :string
  end

  def down
    remove_column :items, :name
  end
end
