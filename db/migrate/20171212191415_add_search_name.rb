class AddSearchName < ActiveRecord::Migration
  def change
    add_column :offerings, :search_name, :string, limit: 6, null: true

    add_index :offerings, [:search_name]
  end
end
