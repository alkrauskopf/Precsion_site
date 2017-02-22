class AddPhoneReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :phone, :string, limit: 13
  end
end
