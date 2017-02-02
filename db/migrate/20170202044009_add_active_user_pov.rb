class AddActiveUserPov < ActiveRecord::Migration
  def change
    change_column :user_povs, :label, :string, limit: 15
    add_column :user_povs, :is_active, :boolean, default: true
  end
end
