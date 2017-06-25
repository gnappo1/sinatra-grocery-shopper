class ChangeDatatypeInLists < ActiveRecord::Migration
  def change
    change_column :lists, :creation_date, :date
  end
end
