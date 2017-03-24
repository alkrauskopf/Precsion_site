class CreatePayTerms < ActiveRecord::Migration
  def change
    create_table :pay_terms do |t|
      t.boolean :e_type, uniq: true
      t.string :title
      t.text :terms
      t.boolean :is_active, default: false

      t.timestamps null: false
    end
  end
end
