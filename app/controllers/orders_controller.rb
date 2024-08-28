class OrdersController < ApplicationController
  before_action :set_order, only: %i[show update destroy]

   # GET /orders
   def index
    @orders = Order.all
    render json: @orders
  end

  # POST /orders

  def create
    @order = Order.new(order_params.except(:price, :commission, :final_price))
    product = Product.find(@order.product_id)
    base_price = product.price
    quantity = @order.quantity

    total_base_price = quantity * base_price
    final_price = params[:order][:final_price].to_d # Ensure this is provided and accurate

    commission = final_price - total_base_price

    @order.price = total_base_price

    if @order.save
      Sale.create!(
        user: @order.user,
        product: product,
        quantity: quantity,
        total_price: total_base_price,
        sale_date: @order.order_date,
        order: @order,
        commission: commission,
        final_price: final_price
      )

      product.update!(stock_level: product.stock_level - quantity)

      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end


  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:order_date, :status, :user_id, :product_id, :quantity)
  end
end
