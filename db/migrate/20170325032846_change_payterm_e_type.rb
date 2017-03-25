class ChangePaytermEType < ActiveRecord::Migration
  def change
    change_column :pay_terms, :e_type, :integer, :default => 0
  end
end
