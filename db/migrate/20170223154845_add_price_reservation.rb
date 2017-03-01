class AddPriceReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :price_cents, :integer, default: 0
  end
end
