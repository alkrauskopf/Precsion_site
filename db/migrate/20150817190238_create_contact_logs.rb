class CreateContactLogs < ActiveRecord::Migration
  def change
    drop_table :email_logs
    create_table :contact_logs do |t|
      t.boolean :was_sent, default: false
      t.string :from_email
      t.string :workplace
      t.string :distribution
      t.text :message

      t.timestamps null: false
    end
  end
end
