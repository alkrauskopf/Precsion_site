class AddEventType < ActiveRecord::Migration
  def change
    add_column :events, :type, :integer, default: 0
    add_column :events, :message, :string, default: ''
  end
end
