class AddAnotherTestimonyCol < ActiveRecord::Migration
  def change
    add_column :offerings, :tst_topic, :string
  end
end
