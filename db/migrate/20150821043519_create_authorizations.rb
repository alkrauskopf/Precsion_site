class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :name
      t.string :long_name

      t.timestamps null: false
    end

  end
end
