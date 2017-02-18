class AddConfirmationNumEnroll < ActiveRecord::Migration
  def change
    add_column :reservations, :confirmation, :string, unique: true
    add_index :reservations, :confirmation
  end
end
