class ChangeStatementColType < ActiveRecord::Migration
  def change
    change_column :offerings, :tst_statement, :text
  end
end
