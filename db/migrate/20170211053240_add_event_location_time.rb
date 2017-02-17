class AddEventLocationTime < ActiveRecord::Migration
  def change
    add_column :events, :location, :text
    add_column :events, :time, :text
  end
end
