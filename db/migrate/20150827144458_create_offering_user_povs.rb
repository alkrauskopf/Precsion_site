class CreateOfferingUserPovs < ActiveRecord::Migration
  def change
    create_table :offering_user_povs do |t|
      t.references :offering, index: true, foreign_key: true
      t.references :user_pov, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
