class OfferingTypeColumnSize < ActiveRecord::Migration
  def up
    change_column :offerings, :offering_type, :string, :limit => 2
  end

  def down
    change_column :offerings, :offering_type, :string, :limit => 2
  end
end
