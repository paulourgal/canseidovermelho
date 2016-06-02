class AddAddressToClients < ActiveRecord::Migration
  def up
    add_column :clients, :address, :string
  end

  def down
    remove_column :clients, :address
  end
end
