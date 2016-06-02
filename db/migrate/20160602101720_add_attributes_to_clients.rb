class AddAttributesToClients < ActiveRecord::Migration
  def up
    add_column :clients, :email, :string
    add_column :clients, :observations, :text
    add_column :clients, :status, :integer
  end

  def down
    remove_column :clients, :email
    remove_column :clients, :observations
    remove_column :clients, :status
  end
end
