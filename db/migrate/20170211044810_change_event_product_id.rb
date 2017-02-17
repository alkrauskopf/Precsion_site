class ChangeEventProductId < ActiveRecord::Migration
  def change
    remove_column :events, :product_id
    add_column :events, :venue_id, :integer
    add_index :events, [:venue_id]
  end
end
