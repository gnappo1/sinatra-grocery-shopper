class Client < ActiveRecord::Base
  validates :name, :address_1, :city, :zipcode, :state, :password, presence: true
  validates :name, uniqueness: true
  validates :zipcode, length: { is: 5 }
  validates :tel_nbr, length: { is: 10 }, presence: { message: "must be 10 digits" }, uniqueness: true
  validates :email, format: { with: /@/ }, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 60 }
  has_secure_password
  belongs_to :shopper
  has_many :lists

end
