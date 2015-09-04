class SetDefaultOfferingPosition < ActiveRecord::Migration
  def change
    change_column :offerings, :position, :integer, default: 999
  end
end
