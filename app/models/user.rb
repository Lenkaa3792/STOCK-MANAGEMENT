class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Remove the has_secure_password line
  # has_secure_password
  
  has_many :sales
  has_many :orders
  has_many :notifications

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  
  # Add Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
