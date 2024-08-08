class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  has_one :delivery
  accepts_nested_attributes_for :order_details, allow_destroy: true

  validates :order_date, presence: true
  validates :status, presence: true
end
