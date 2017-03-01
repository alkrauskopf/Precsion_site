class ChangePaymentFullResponse < ActiveRecord::Migration
  def change
    add_column :payments, :buyable_type, :string
    change_column :payments, :payment_method, :text
  end
end
