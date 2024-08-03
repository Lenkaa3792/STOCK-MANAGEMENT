class Notification < ApplicationRecord
  belongs_to :user

  validates :message, :notification_date, :status, presence: true
end
