class RenameFromEmailContactLog < ActiveRecord::Migration
  def change
    rename_column :contact_logs, :from_email, :user_email
  end
end
