class AddOfferingIdColumn < ActiveRecord::Migration
  def change
    add_column :images, :offering_id, :integer
  end
end
