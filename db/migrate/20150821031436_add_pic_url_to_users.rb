class AddPicUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pic_url, :string
  end
end
