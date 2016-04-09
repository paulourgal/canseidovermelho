class CreateOutgoings < ActiveRecord::Migration
  def change
    create_table :outgoings do |t|
      t.timestamps
    end
  end
end
