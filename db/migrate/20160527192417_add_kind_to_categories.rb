class AddKindToCategories < ActiveRecord::Migration
  def up
    add_column :categories, :kind, :integer
  end

  def down
    remove_column :categories, :kind
  end
end
