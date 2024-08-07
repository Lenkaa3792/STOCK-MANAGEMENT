class SalesController < ApplicationController
  before_action :set_sale, only: %i[show update destroy]
  before_action :set_product, only: %i[create update]

  # GET /sales
  def index
    @sales = Sale.all
    render json: @sales
  end

  # GET /sales/:id
  def show
    render json: @sale
  end

  # POST /sales
  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      update_product_stock(@sale.product_id, @sale.quantity)
      render json: @sale, status: :created, location: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sales/:id
  def update
    if @sale.update(sale_params)
      render json: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sales/:id
  def destroy
    # First, increase the stock level of the product
    update_product_stock(@sale.product_id, -@sale.quantity)
    @sale.destroy
    head :no_content
  end

  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def set_product
    @product = Product.find(params[:sale][:product_id])
  end

  def sale_params
    params.require(:sale).permit(:product_id, :user_id, :quantity, :total_price, :sale_date)
  end

  def update_product_stock(product_id, quantity_change)
    product = Product.find(product_id)
    new_stock_level = product.stock_level - quantity_change
    if new_stock_level < 0
      render json: { error: 'Insufficient stock' }, status: :unprocessable_entity
      raise ActiveRecord::Rollback
    else
      product.update(stock_level: new_stock_level)
    end
  end
end
