class AddDateToSales < ActiveRecord::Migration
  def up
    add_column :sales, :date, :date
  end

  def down
    remove_column :sales, :date
  end
end
