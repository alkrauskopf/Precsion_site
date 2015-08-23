class RenameUserPicUrl < ActiveRecord::Migration
  def change
    rename_column :users, :pic_url, :picture
  end
end
