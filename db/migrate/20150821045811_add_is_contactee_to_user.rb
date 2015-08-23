class AddIsContacteeToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_contactee, :boolean, default: false
  end
end
