class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.string :name
      t.string :brief
      t.string :description
      t.string :image
      t.string :resource_links

      t.timestamps null: false
    end
  end
end
