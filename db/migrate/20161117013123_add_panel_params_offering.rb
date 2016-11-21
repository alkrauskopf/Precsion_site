class AddPanelParamsOffering < ActiveRecord::Migration
  def change
    add_column :offerings, :panel_header, :string
    add_column :offerings, :panel_color, :string
  end
end
