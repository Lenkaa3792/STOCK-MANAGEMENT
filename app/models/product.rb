class Product < ApplicationRecord
    has_many :sales
    has_many :order_details
    has_many :orders, through: :order_details
    validates :name, presence: true
    validates :price, :cost, numericality: { greater_than_or_equal_to: 0 }
    validates :stock_level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
