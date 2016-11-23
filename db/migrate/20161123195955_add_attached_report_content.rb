class AddAttachedReportContent < ActiveRecord::Migration
  def change
    add_attachment :contents, :attached_report
  end
end
