class CreateClient < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :tel_nbr
      t.string :address
      t.string :password_digest
      t.integer :shopper_id
      t.timestamps null: false
    end
  end
end
