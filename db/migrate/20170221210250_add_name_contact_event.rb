class AddNameContactEvent < ActiveRecord::Migration
  def change
    add_column :events, :name, :string
    add_column :events, :contact_name, :string
    add_column :events, :contact_email, :string
  end
end
