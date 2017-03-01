class AddPaymentReference < ActiveRecord::Migration
  def change
    add_column :payments, :reference, :string
    change_column :payments, :payment_method, :string
  end
end
