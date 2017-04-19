class AddTstOrgOffering < ActiveRecord::Migration
  def change
    add_column :offerings, :tst_organization, :string
  end
end
