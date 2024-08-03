class Delivery < ApplicationRecord
  belongs_to :order

  validates :scheduled_date, presence: true
  validates :status, presence: true
end
