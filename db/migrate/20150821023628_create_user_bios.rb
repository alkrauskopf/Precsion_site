class CreateUserBios < ActiveRecord::Migration
  def change
    create_table :user_bios do |t|
      t.string :education
      t.text :history
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
