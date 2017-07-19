class Shopper < ActiveRecord::Base
  validates_presence_of :name, :email, :tel_nbr, :password, :price_per_bag, :neighborhood, presence: true
  validates :name, uniqueness: true
  validates :email, format: { with: /@/ }, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 60 }
  validates :tel_nbr, length: { is: 10 }, presence: { message: "must be 10 digits" }, uniqueness: true
  has_secure_password
  has_many :clients
  has_many :lists, through: :clients

end
