class AddCommissionAndFinalPriceToSales < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :commission, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :sales, :final_price, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
