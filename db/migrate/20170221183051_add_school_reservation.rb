class AddSchoolReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :school, :string, default: nil
  end
end
