class AddTypeOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :offering_type, :string, limit: 1, default: 'O'
  end
end
