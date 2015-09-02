class SetDefaultOfferingPosition < ActiveRecord::Migration
  def change
    change_column :offerings, :position, :type, default: 999
  end
end
