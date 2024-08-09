class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :order_date, presence: true
  validates :status, presence: true
  validates :product_id, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # You might need to adjust methods or scopes depending on your requirements
end
