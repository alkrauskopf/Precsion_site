class ChangePaymentTransaction < ActiveRecord::Migration
  def change
    rename_column :payments, :transaction, :description
  end
end
