class UserBioBriefChange < ActiveRecord::Migration
  def change
    add_column :user_bios, :new_brief, :text
    execute "UPDATE user_bios SET new_brief = brief"
    remove_column :user_bios, :brief
    rename_column :user_bios, :new_brief, :brief
  end
end
