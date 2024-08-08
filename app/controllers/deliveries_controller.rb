class DeliveriesController < ApplicationController
  before_action :set_delivery, only: %i[show update destroy]

  # GET /deliveries
  def index
    @deliveries = Delivery.all
    render json: @deliveries
  end

  # GET /deliveries/:id
  def show
    render json: @delivery
  end

  # POST /deliveries
  def create
    @delivery = Delivery.new(delivery_params)
    if @delivery.save
      render json: @delivery, status: :created
    else
      render json: @delivery.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deliveries/:id
  def update
    if @delivery.update(delivery_params)
      render json: @delivery
    else
      render json: @delivery.errors, status: :unprocessable_entity
    end
  end

  # DELETE /deliveries/:id
  def destroy
    @delivery.destroy
    head :no_content
  end

  private

  def set_delivery
    @delivery = Delivery.find(params[:id])
  end

  def delivery_params
    params.require(:delivery).permit(:order_id, :scheduled_date, :delivery_date, :status, :address)
  end
end
