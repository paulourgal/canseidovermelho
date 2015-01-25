class CompleteUsersColumns < ActiveRecord::Migration
  def up
    add_column :users, :email, :string, null: false
    add_column :users, :password_salt, :string
    add_column :users, :password_hash, :string
  end

  def down
    remove_column :users, :email
    remove_column :users, :password_salt
    remove_column :users, :password_hash
  end
end
