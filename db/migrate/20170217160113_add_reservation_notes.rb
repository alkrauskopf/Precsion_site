class AddReservationNotes < ActiveRecord::Migration
  def change
    add_column :reservations, :notes, :text
  end
end
