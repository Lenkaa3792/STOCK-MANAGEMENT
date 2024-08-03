class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.references :order, null: false, foreign_key: true
      t.datetime :scheduled_date
      t.datetime :delivery_date
      t.string :status

      t.timestamps
    end
  end
end
