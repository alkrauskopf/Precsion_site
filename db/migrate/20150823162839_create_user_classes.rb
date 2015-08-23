class CreateUserClasses < ActiveRecord::Migration
  def change
    create_table :user_classes do |t|
      t.string :abbrev, :limit => 8
      t.string :name, :limit => 30
      t.text :description

      t.timestamps null: false
    end
  end
end
