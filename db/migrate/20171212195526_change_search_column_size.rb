class ChangeSearchColumnSize < ActiveRecord::Migration
  def change
    change_column :offerings, :search_name, :string, limit: 10, null: true
  end
end
