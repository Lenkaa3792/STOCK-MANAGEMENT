class OrderDetailsController < ApplicationController
    before_action :set_order_detail, only: %i[show update destroy]
  
    # GET /order_details
    def index
      @order_details = OrderDetail.all
      render json: @order_details
    end
  
    # GET /order_details/:id
    def show
      render json: @order_detail
    end
  
    # POST /order_details
    def create
      @order_detail = OrderDetail.new(order_detail_params)
      if @order_detail.save
        render json: @order_detail, status: :created, location: @order_detail
      else
        render json: @order_detail.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /order_details/:id
    def update
      if @order_detail.update(order_detail_params)
        render json: @order_detail
      else
        render json: @order_detail.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /order_details/:id
    def destroy
      @order_detail.destroy
      head :no_content
    end
  
    private
  
    def set_order_detail
      @order_detail = OrderDetail.find(params[:id])
    end
  
    def order_detail_params
      params.require(:order_detail).permit(:order_id, :product_id, :quantity, :price)
    end
  end
  