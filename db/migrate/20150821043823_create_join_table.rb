class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :authorizations do |t|
       t.index [:user_id, :authorization_id]
       t.index [:authorization_id, :user_id]
    end
  end
end
