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
      # If you need to create order details
      create_order_details(@order)
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
    params.require(:order).permit(
      :order_date,
      :status,
      :user_id
      # Removed :price from here
    )
  end

  def create_order_details(order)
    # Example logic to create order details
    # Assuming you are passing order details in params
    order_details_params = params[:order][:order_details] || []
    order_details_params.each do |detail|
      OrderDetail.create!(
        order_id: order.id,
        product_id: detail[:product_id],
        quantity: detail[:quantity],
        price: detail[:price] # Make sure price is handled in OrderDetail
      )
    end
  end
end
