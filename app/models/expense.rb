class Expense < ApplicationRecord
    validates :description, :amount, :expense_date, :category, presence: true
    validates :amount, numericality: { greater_than_or_equal_to: 0 }
  end
  