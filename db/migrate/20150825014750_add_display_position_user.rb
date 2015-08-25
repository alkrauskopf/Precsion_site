class AddDisplayPositionUser < ActiveRecord::Migration
  def change
    add_column :users, :display_position, :integer, default: 9999
  end
end
