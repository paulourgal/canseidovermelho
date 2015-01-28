class CreateIncomings < ActiveRecord::Migration
  def change
    create_table :incomings do |t|
      t.integer :kind
      t.date :day
      t.decimal :value
      t.integer :user_id

      t.timestamps
    end
  end
end
