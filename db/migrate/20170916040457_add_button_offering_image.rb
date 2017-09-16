class AddButtonOfferingImage < ActiveRecord::Migration
  def change
    add_column :offering_images, :is_button, :boolean, default: false
  end
end
