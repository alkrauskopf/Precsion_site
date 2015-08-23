class ReformatEducationUserBio < ActiveRecord::Migration
  def change

    remove_column :user_bios, :education
    add_column :user_bios, :education, :text, default: ''
  end
end
