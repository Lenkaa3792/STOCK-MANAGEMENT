class OrdersController < ApplicationController
  before_action :set_order, only: %i[show update destroy]

  # GET /orders
  def index
    @orders = Order.all
    render json: @orders
  end

  # GET /orders/:id
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    if @order.save
      # Create a sale when an order is made
      Sale.create!(
        user: @order.user,
        product: @order.product,
        quantity: @order.quantity,
        total_price: @order.price,
        sale_date: @order.order_date,
        order: @order
      )

      # Update stock level after sale
      @order.product.update!(stock_level: @order.product.stock_level - @order.quantity)

      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/:id
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/:id
  def destroy
    @order.destroy
    head :no_content
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:order_date, :status, :user_id, :product_id, :quantity, :price)
  end
end
