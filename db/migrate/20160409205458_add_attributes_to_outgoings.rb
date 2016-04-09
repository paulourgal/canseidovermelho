class AddAttributesToOutgoings < ActiveRecord::Migration
  def up
    add_column :outgoings, :day, :date
    add_column :outgoings, :kind, :integer
    add_column :outgoings, :value, :decimal
    add_column :outgoings, :description, :string
  end

  def down
    remove_column :outgoings, :day
    remove_column :outgoings, :kind
    remove_column :outgoings, :value
    remove_column :outgoings, :description
  end
end
