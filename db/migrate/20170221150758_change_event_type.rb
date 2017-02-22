class ChangeEventType < ActiveRecord::Migration
  def change
    rename_column :events, :type, :e_type
  end
end
