class AddAddressToDeliveries < ActiveRecord::Migration[7.0]
  def change
    add_column :deliveries, :address, :string
  end
end
