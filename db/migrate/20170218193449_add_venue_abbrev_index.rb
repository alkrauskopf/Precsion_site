class AddVenueAbbrevIndex < ActiveRecord::Migration
  def change
    remove_index :reservations, :confirmation
    add_index :reservations, :confirmation, unique: true
    add_index :venues, :abbrev, unique: true
  end
end
