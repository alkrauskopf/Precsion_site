class ChangeOfferingsTable < ActiveRecord::Migration
  def change
    change_table :offerings do |t|
      t.remove :image, :resource_links
      t.integer :position
      t.boolean :visible?
    end
  end
end
