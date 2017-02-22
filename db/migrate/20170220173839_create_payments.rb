class CreatePayments < ActiveRecord::Migration
  def change
#    drop_table :payments
    create_table :payments do |t|

#      t.references :buyable, index: true, polymorhpic: true, foreign_key: true
      t.references :buyable, index: true, polymorhpic: true
      t.monetize :price
      t.integer :status
      t.integer :payment_method
      t.string :response_id
      t.string :full_response

      t.timestamps null: false
    end
  end
end
