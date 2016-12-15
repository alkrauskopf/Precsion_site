class CreateOfferingLogs < ActiveRecord::Migration
  def change
    create_table :offering_logs do |t|
      t.integer :offering_id
      t.text :period
      t.integer :counter, default: 1

      t.timestamps null: false
    end
    add_index "offering_logs", ["offering_id"]
  end
end
