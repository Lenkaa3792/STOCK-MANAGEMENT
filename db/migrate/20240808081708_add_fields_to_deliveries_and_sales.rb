class AddFieldsToDeliveriesAndSales < ActiveRecord::Migration[7.0]
  def change
    # Add any new fields or indexes as needed

    # For example, you might want to add an index on the status of deliveries:
    add_index :deliveries, :status

    # Or add a column for a sales reference in the deliveries table (if needed):
    add_reference :sales, :delivery, foreign_key: true

    # Also, ensure there's a way to track delivery ID in sales, if not already there:
    add_reference :sales, :order, foreign_key: true unless column_exists?(:sales, :order_id)
  end
end
