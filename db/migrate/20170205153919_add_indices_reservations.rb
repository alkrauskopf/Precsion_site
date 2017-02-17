class AddIndicesReservations < ActiveRecord::Migration
  def change
    add_index :events, :product_id
    add_index :reservations, :event_id
    change_column :reservations, :status, :integer, :default=> 0
  end
end
