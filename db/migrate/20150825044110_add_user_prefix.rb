class AddUserPrefix < ActiveRecord::Migration
  def change
    add_column :users, :prefix, :string, length: 5
  end
end
