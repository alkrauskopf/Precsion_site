class RedoVenueAbbrev < ActiveRecord::Migration
  def change
    remove_column :venues, :abbrv
    add_column :venues, :abbrev, :string, limit: 4
  end
end
