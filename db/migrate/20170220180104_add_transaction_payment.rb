class AddTransactionPayment < ActiveRecord::Migration
  def change
    add_column :payments, :transaction, :string
  end
end
