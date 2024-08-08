class ConsolidateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    # Remove the order_details table
    drop_table :order_details

    # Add fields to the orders table
    add_column :orders, :product_id, :integer
    add_column :orders, :quantity, :integer
    add_column :orders, :price, :decimal
  end
end
