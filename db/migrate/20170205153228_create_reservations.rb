class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :event_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :status

      t.timestamps null: false
    end
  end
end
