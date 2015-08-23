class CreateUserAuthorizations < ActiveRecord::Migration
  def change
    drop_table :authorizations_users
    create_table :user_authorizations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :authorization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
