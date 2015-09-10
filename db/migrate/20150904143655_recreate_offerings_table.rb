class RecreateOfferingsTable < ActiveRecord::Migration
  def change
    drop_table :offerings
    drop_table :offering_user_povs
    
    create_table :offerings do |t|
      t.string :name
      t.text :brief
      t.text :description
      t.integer :display_position, default: 999
      t.integer :parent_id
      t.boolean :is_visible, default: false
    end

    create_table :offering_user_povs do |t|
      t.references :offering, index: true, foreign_key: true
      t.references :user_pov, index: true, foreign_key: true

      t.timestamps null: false
    end

  end
end
