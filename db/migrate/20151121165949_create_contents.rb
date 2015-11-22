class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :offering_id
      t.string :content_url
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
