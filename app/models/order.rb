class Order < ApplicationRecord
  belongs_to :shipping_company
  belongs_to :vehicle
  belongs_to :product

  validates :code, :estimated_delivery_date, presence: true
  validate :estimated_delivery_date_is_future

  before_validation :generate_code
 
  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end

  def estimated_delivery_date_is_future
    if self.estimated_delivery_date.present? && self.estimated_delivery_date <= Date.today
      self.errors.add(:estimated_delivery_date, "data deve ser posterior.")
    end
  end
end

