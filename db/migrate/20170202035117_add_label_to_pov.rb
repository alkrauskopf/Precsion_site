class AddLabelToPov < ActiveRecord::Migration
  def change
    add_column :user_povs, :label, :string, limit: 12
  end
end
