class ReplaceAbbrevCol < ActiveRecord::Migration
  def change
    remove_column :venues, :abbrev
    add_column :venues, :abbrv, :string
  end
end
