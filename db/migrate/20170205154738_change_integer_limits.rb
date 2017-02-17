class ChangeIntegerLimits < ActiveRecord::Migration
  def change
    change_column :events, :price, :integer, :limit => 8
  end
end
