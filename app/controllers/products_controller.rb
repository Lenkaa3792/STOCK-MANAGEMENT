class ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  # GET /products
  def index
    @products = Product.all
    render json: @products
  end

  # GET /products/:id
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    if @product.save
      create_expense(@product)
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/:id
  def update
    previous_cost = @product.cost
    if @product.update(product_params)
      if @product.cost != previous_cost
        create_expense(@product)
      end
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :cost, :stock_level, :category)
  end

  def create_expense(product)
    Expense.create(
      amount: product.cost,
      description: "Cost of product #{product.name}",
      date: Date.today,
      category: "Product Cost"
    )
  end
end
