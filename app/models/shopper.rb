class Shopper < ActiveRecord::Base
  validates_presence_of :name, :email, :tel_nbr, :password, :price_per_bag, :location, presence: true
  validates :name, :email, :tel_nbr, uniqueness: true
  has_secure_password
  has_many :clients
  has_many :lists


  extend Parser::ClassMethods
  include Parser::InstanceMethods
end
