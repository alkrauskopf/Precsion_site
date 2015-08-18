class RenameFromEmailEmailLog < ActiveRecord::Migration
  def change
    rename_column :email_logs, :from_email, :user_email
  end
end
