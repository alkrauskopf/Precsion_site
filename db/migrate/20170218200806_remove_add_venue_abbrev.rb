class RemoveAddVenueAbbrev < ActiveRecord::Migration
  def change
    remove_column :venues, :abbrev
    add_column :venues, :abbrev, :string
  end
end
