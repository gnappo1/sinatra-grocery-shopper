class List < ActiveRecord::Base
  validates_presence_of :name, :creation_date, :notes, :items_quantities, presence: true
  belongs_to :shopper
  belongs_to :client


  extend Parser::ClassMethods
  include Parser::InstanceMethods
end
