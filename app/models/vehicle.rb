class Vehicle < ApplicationRecord
  belongs_to :shipping_company
  validates :plate, :brand, :vehicle_model, :fabrication_year, presence: true
  validates :plate, uniqueness: true
  validates :fabrication_year, numericality: { only_integer: true }
  validates :fabrication_year, length: { is: 4 }
end
