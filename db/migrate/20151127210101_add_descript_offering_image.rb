class AddDescriptOfferingImage < ActiveRecord::Migration
  def change
    add_column :offering_images, :description, :text
  end
end
