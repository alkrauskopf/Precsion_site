class AddIsEmaileeUser < ActiveRecord::Migration
  def change
    add_column :users, :is_emailee, :boolean, default: false
  end
end
