class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.text :description
      t.decimal :amount
      t.datetime :expense_date
      t.string :category

      t.timestamps
    end
  end
end
