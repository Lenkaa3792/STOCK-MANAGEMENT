class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.decimal :cost
      t.integer :stock_level
      t.string :category

      t.timestamps
    end
  end
end
