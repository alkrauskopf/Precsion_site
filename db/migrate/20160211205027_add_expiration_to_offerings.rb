class AddExpirationToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :expire_date, :date
  end
end
