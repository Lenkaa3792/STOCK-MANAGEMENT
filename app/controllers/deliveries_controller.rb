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
      create_expense(@delivery)
      update_order_status_if_needed(@delivery)
      render json: @delivery, status: :created, location: @delivery
    else
      render json: @delivery.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deliveries/:id
  def update
    previous_delivery = @delivery.dup
    if @delivery.update(delivery_params)
      # Only create a new expense if the cost or other related attributes change
      if delivery_cost_changed?(previous_delivery, @delivery)
        create_expense(@delivery)
      end
      # Update order status if needed
      update_order_status_if_needed(@delivery)
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
    params.require(:delivery).permit(:order_id, :scheduled_date, :delivery_date, :status, :cost)
  end

  def create_expense(delivery)
    Expense.create(
      amount: delivery.cost,
      description: "Delivery cost for order #{delivery.order_id}",
      date: Date.today,
      category: "Delivery"
    )
  end

  def delivery_cost_changed?(previous, current)
    previous.cost != current.cost
  end

  def update_order_status_if_needed(delivery)
    if delivery.status == "delivered"
      order = Order.find(delivery.order_id)
      order.update(status: "delivered")
    end
  end
end
