class AddVenueAbbrev < ActiveRecord::Migration
  def change
    add_column :venues, :abbrev, :string, limit: 4
  end
end
