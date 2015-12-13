class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :offering_id
      t.integer :stat
      t.string :name
      t.integer :position
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
