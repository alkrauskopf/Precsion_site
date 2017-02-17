class ChangePriceMontize < ActiveRecord::Migration
  def change
    rename_column :events, :price, :price_cents
  end
end
