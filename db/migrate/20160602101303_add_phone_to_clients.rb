class AddPhoneToClients < ActiveRecord::Migration
  def up
    add_column :clients, :phone, :string
  end

  def down
    remove_column :clients, :phone
  end
end
