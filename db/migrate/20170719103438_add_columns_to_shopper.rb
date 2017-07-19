class AddColumnsToShopper < ActiveRecord::Migration
  def change
    add_column :shoppers, :city, :string
    add_column :shoppers, :state, :string
  end
end
