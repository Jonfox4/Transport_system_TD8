class ShippingCompany < ApplicationRecord
  validates :corporate_name, :brand_name, :email_domain, :registration_number, :address, :city, :state, presence: true
  validates :email_domain, :corporate_name, :brand_name, :registration_number, uniqueness: true
  validates :registration_number, numericality: { only_integer: true }
  validates :registration_number, length: { is: 14 }

  has_many :users
  has_many :vehicles
  has_many :prices
  has_many :time_deliveries
end
