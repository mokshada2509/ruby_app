class RemoveCategoryIdFromBook < ActiveRecord::Migration
  def change
    remove_column :books, :Category_id, :integer
  end
end
