class RecreateOfferingsTable < ActiveRecord::Migration
  def change
    drop_table :offerings

    create_table :offerings do |t|
      t.string :name
      t.text :brief
      t.text :description
      t.integer :display_position, default: 999
      t.integer :parent_id
      t.boolean :is_visible, default: false
    end
  end
end
