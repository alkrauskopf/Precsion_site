class RenameEscentType < ActiveRecord::Migration
  def change
    rename_column :escents, :type, :escent_type
  end
end
