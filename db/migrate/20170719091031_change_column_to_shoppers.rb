class ChangeColumnToShoppers < ActiveRecord::Migration
  def change
    rename_column :shoppers, :location, :neighborhood
  end
end
