class RenameResConfirmation < ActiveRecord::Migration
  def change
    rename_column :reservations, :confirmation, :enrollment
  end
end
