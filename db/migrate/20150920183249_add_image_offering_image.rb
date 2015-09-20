class AddImageOfferingImage < ActiveRecord::Migration
  def change
    add_attachment :offering_images, :image
  end
end
