class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name, :limit=> 64
      t.text :notes
      t.boolean :is_active, :default=> true

      t.timestamps null: false
    end
    drop_table :products
  end
end
