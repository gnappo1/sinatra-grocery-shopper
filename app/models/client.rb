class Client < ActiveRecord::Base
  validates_presence_of :name, :email, :tel_nbr, :address, :password, presence: true
  validates :name, :email, :tel_nbr, uniqueness: true
  has_secure_password
  belongs_to :shopper
  has_many :lists


  extend Parser::ClassMethods
  include Parser::InstanceMethods
end
