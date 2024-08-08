class AddDeliveryCostToDeliveries < ActiveRecord::Migration[7.0]
  def change
    add_column :deliveries, :delivery_cost, :integer
  end
end
