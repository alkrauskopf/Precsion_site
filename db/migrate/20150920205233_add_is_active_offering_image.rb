class AddIsActiveOfferingImage < ActiveRecord::Migration
  def change
    add_column :offering_images, :is_active, :boolean, default: false
  end
end
