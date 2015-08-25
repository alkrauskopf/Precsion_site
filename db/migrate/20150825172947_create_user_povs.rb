class CreateUserPovs < ActiveRecord::Migration
  def change
    create_table :user_povs do |t|
      t.string :name
      t.string :url
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
