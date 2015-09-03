class ChangeOfferingsTable < ActiveRecord::Migration
  def change
    change_table :offerings do |t|
      t.remove :image, :resource_links
      t.integer :display_position
      t.boolean :is_visible
    end
  end
end
