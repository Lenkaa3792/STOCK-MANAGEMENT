class OrdersController < ApplicationController
  before_action :set_order, only: %i[show update destroy]

  # GET /orders
  def index
    @orders = Order.includes(order_details: :product).all
    render json: @orders.as_json(include: { order_details: { include: :product } })
  end

  # GET /orders/:id
  def show
    render json: @order.as_json(include: { order_details: { include: :product } })
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    if @order.save
      render json: @order.as_json(include: { order_details: { include: :product } }), status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/:id
  def update
    if @order.update(order_params)
      render json: @order.as_json(include: { order_details: { include: :product } })
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
      :user_id,
      order_details_attributes: [:id, :product_id, :quantity, :price, :_destroy]
    )
  end
end
