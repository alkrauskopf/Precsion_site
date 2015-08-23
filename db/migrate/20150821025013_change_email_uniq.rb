class ChangeEmailUniq < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :email
      t.string :email, :unique=>true
      t.index :email
    end
  end
end
