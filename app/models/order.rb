class Order < ApplicationRecord
  belongs_to :shipping_company
  belongs_to :vehicle
  belongs_to :product

  validates :delivery_date, :customer_name, :customer_address, :product_id, :vehicle_id, :shipping_company_id, presence: true
  validate  :delivery_date_is_future


  private

  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end

  def delivery_date_is_future
    if self.delivery_date.present? && self.delivery_date <= Date.today
      self.errors.add(:delivery_date, "data deve ser posterior.")
    end
  end
end

