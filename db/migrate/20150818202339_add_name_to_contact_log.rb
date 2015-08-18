class AddNameToContactLog < ActiveRecord::Migration
  def change
    add_column :contact_logs, :name, :string
  end
end
