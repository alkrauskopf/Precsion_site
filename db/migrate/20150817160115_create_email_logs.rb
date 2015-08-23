class CreateEmailLogs < ActiveRecord::Migration
  def change
    create_table :email_logs do |t|
      t.string :from_email
      t.string :workplace
      t.string :distribution
      t.text :message

      t.timestamps null: false
    end
  end
end
