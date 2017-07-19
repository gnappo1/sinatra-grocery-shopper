class List < ActiveRecord::Base
  validates :name, :creation_date, :items_quantities, presence: true
  belongs_to :shopper
  belongs_to :client
end
