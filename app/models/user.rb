class User < ApplicationRecord
    has_secure_password
    
    has_many :sales
    has_many :orders
    has_many :notifications
  
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
  end
  