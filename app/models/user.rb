class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :sales
  has_many :orders
  has_many :notifications

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  
end
