class RemoveCategoryIdFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :Category_id, :integer
  end
end
