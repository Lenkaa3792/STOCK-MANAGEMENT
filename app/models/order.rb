class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_one :delivery

  validates :order_date, presence: true
  validates :status, presence: true
end
