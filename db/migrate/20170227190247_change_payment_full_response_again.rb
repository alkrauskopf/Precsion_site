class ChangePaymentFullResponseAgain < ActiveRecord::Migration
  def change
    change_column :payments, :payment_method, :string
    change_column :payments, :full_response, :text
  end
end
