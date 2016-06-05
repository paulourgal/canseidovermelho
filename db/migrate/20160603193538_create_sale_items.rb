class CreateSaleItems < ActiveRecord::Migration
  def change
    create_table :sale_items do |t|

      t.timestamps null: false
    end
  end
end
