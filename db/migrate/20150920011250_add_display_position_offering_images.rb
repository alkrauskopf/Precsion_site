class AddDisplayPositionOfferingImages < ActiveRecord::Migration
  def change
    add_column :offering_images, :display_position, :integer, default: 1
  end
end
