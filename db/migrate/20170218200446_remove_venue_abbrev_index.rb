class RemoveVenueAbbrevIndex < ActiveRecord::Migration
  def change
    remove_index :venues, :abbrev
  end
end
