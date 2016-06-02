class AddNameToClients < ActiveRecord::Migration
  def up
    add_column :clients, :name, :string
  end

  def down
    remove_column :clients, :name
  end
end
