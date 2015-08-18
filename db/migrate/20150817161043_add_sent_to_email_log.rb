class AddSentToEmailLog < ActiveRecord::Migration
  def change
    add_column :email_logs, :was_sent, :boolean, default: false
  end
end
