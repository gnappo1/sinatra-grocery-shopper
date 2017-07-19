class AddColumnsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :address_2, :string
    add_column :clients, :city, :string
    add_column :clients, :zipcode, :integer
    add_column :clients, :state, :string  
  end
end
