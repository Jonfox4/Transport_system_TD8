class TimeDelivery < ApplicationRecord
  belongs_to :shipping_company
  validates :min_distance, :max_distance, :time, presence: true
end
