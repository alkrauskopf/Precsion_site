class AddUserClassUser < ActiveRecord::Migration
  def change
    add_column :users, :user_class_id, :integer, index: true, foreign_key: true
  end
end
