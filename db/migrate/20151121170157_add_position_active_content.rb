class AddPositionActiveContent < ActiveRecord::Migration
  def change
    add_column :contents, :position, :integer, default: 1
    add_column :contents, :is_active, :boolean, default: false
  end
end
