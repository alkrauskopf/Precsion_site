class AddBriefUserBio < ActiveRecord::Migration
  def change
    add_column :user_bios, :brief, :string, default: ''
    add_column :user_bios, :passion, :string, default: ''
  end
end
