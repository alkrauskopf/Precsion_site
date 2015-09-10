class RenameImageToOfferingImage < ActiveRecord::Migration
  def change
    rename_table :images, :offering_images
    add_column :offering_images, :is_carousel_img, :boolean, default: false
  end
end
