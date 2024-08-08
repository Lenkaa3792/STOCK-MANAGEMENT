class Delivery < ApplicationRecord
  belongs_to :order
  has_one :sale

  before_update :handle_delivery_update

  private

  def handle_delivery_update
    if status_changed? && status == "delivered"
      # Create a sale
      Sale.create!(
        user: order.user,
        product: order.product,
        quantity: order.quantity,
        total_price: (order.quantity * order.price) + delivery_cost, # Include delivery fee
        sale_date: delivery_date || Time.current,
        order: order,
        delivery: self
      )

      # Update stock level after sale
      order.product.update!(stock_level: order.product.stock_level - order.quantity)

      # Record delivery cost as an expense
      Expense.create!(
        description: "Delivery cost for order ##{order.id}",
        amount: delivery_cost,
        expense_date: Time.current,
        category: "Delivery"
      )
    end
  end
end
