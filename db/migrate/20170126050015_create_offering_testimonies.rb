class CreateOfferingTestimonies < ActiveRecord::Migration
  def change
    create_table :offering_testimonies do |t|
      t.integer :offering_id
      t.integer :testimony_id

      t.timestamps null: false
    end
    add_index "offering_testimonies", ["offering_id"]
    add_index "offering_testimonies", ["testimony_id"]
  end
end
