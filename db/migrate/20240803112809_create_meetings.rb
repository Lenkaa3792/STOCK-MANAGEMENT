class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.string :title
      t.text :description
      t.datetime :scheduled_date
      t.datetime :reminder_date
      t.string :location

      t.timestamps
    end
  end
end
