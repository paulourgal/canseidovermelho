class RemoverKindFromIncomingsAndOutgoings < ActiveRecord::Migration
  def up
    remove_column :incomings, :kind
    remove_column :outgoings, :kind
  end

  def down
    add_column :incomings, :kind, :integer
    add_column :outgoings, :kind, :integer
  end
end
