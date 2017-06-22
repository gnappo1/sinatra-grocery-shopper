class CreateShopper < ActiveRecord::Migration
  def change
    create_table :shoppers do |t|
      t.string :name
      t.string :email
      t.string :tel_nbr
      t.string :password_digest
      t.string :price_per_bag
      t.string :location
      t.timestamps null: false
    end
  end
end
