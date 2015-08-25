class ChangeUserContacteeField < ActiveRecord::Migration
  def change
    remove_column :users, :is_contactee
    add_column :users, :contactee, :string, default: 'No'
  end
end
