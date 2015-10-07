class AddEscentActive < ActiveRecord::Migration
  def change
    add_column :escents, :is_active, :boolean, default: false
  end
end
