class AddIsHeadOfferingImage < ActiveRecord::Migration
  def change
    add_column :offering_images, :is_head, :boolean
  end
end
