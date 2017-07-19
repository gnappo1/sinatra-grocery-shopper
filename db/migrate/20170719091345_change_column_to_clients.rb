class ChangeColumnToClients < ActiveRecord::Migration
  def change
    rename_column :clients, :address, :address_1
  end
end
