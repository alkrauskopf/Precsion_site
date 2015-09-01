class VisibleColumnOffering < ActiveRecord::Migration
  def change
    change_table :offerings do |t|
      t.rename :visible?, :visible
    end
  end
end
