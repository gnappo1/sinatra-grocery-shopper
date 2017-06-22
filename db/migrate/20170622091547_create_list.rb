class CreateList < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.string :creation_date
      t.string :notes
      t.integer :client_id
      t.integer :shopper_id
      t.string :items_quantities
      t.timestamps null: false
    end
  end
end
