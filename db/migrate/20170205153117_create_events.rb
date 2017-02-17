class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :product_id
      t.date :start_date
      t.date :end_date
      t.integer :capacity
      t.integer :price

      t.timestamps null: false
    end
  end
end
