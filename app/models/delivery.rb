class Delivery < ApplicationRecord
  belongs_to :order
  has_one :sale

  before_update :create_sale_if_delivered

  private

  def create_sale_if_delivered
    return unless status_changed? && status == "delivered"

    # Assuming each order has multiple order details and each detail corresponds to a sale of that product
    order.order_details.each do |detail|
      Sale.create!(
        user: order.user,
        product: detail.product,
        quantity: detail.quantity,
        total_price: detail.quantity * detail.price,
        sale_date: delivery_date || Time.current
      )

      # Update stock level after sale
      detail.product.update!(stock_level: detail.product.stock_level - detail.quantity)
    end
  end
end
