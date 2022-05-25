class AddCatogeryIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :catego_id, :integer
  end
end
