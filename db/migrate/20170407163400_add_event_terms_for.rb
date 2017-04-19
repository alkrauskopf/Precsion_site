class AddEventTermsFor < ActiveRecord::Migration
  def change
    add_column :events, :terms_for, :string, default: nil
  end
end
