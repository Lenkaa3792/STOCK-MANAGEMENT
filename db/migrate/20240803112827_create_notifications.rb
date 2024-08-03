class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.text :message
      t.datetime :notification_date
      t.string :status

      t.timestamps
    end
  end
end
