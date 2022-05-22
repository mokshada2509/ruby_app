class RemoveCategoIdFromBook < ActiveRecord::Migration
  def change
    remove_column :books, :catego_id, :integer
  end
end
