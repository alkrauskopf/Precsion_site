class AddIsPEmaileeUser < ActiveRecord::Migration
  def change
    add_column :users, :is_p_emailee, :boolean, default: false
  end
end
