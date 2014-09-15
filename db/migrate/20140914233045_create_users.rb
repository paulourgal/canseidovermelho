class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.date   :birth_date

      t.timestamps
    end

    add_index :users, :id
  end
end
