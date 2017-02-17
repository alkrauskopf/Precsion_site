class AddWasNotifiedReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :was_notified, :boolean, default: false
  end
end
