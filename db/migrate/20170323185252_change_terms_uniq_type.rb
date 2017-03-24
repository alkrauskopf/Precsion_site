class ChangeTermsUniqType < ActiveRecord::Migration
  def change
    change_table :pay_terms do |t|
      t.remove :e_type
      t.boolean :e_type, :unique=>false
    end
  end
end
