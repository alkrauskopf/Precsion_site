class AddIsHeaderOfferingImage < ActiveRecord::Migration
  def change
    add_column :offering_images, :is_header, :boolean, default: false
  end
end
