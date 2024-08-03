class Meeting < ApplicationRecord
    validates :title, :scheduled_date, presence: true
    validates :reminder_date, :location, presence: true
  end
  