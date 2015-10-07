class CreateEscents < ActiveRecord::Migration
  def change
    create_table :escents do |t|
      t.string :name
      t.string :url
      t.integer :position, default: 1
      t.string :type, length: 2

      t.timestamps null: false
    end
  end
end
