class AddDefaultOfferingPage < ActiveRecord::Migration
  def change
    add_column :offerings, :is_default, :boolean, :default=> false
  end
end
