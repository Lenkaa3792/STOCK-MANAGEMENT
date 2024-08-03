class SalesController < ApplicationController
    before_action :set_sale, only: %i[show update destroy]
  
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
      @sale.destroy
      head :no_content
    end
  
    private
  
    def set_sale
      @sale = Sale.find(params[:id])
    end
  
    def sale_params
      params.require(:sale).permit(:product_id, :user_id, :quantity, :total_price, :sale_date)
    end
  end
  