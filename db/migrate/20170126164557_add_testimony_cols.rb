class AddTestimonyCols < ActiveRecord::Migration
  def change
    add_column :offerings, :tst_person_name, :string
    add_column :offerings, :tst_person_role, :string
    add_column :offerings, :tst_statement, :string
    add_column :offerings, :tst_view_label, :string, default: 'Customer Feedback'
    add_column :offerings, :tst_video, :text
  end
end
