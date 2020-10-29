require 'bcrypt'
class User < ApplicationRecord
  validates :first_name, :last_name, :description, :email, :age, presence: true
  validates :age, numericality: true, inclusion: { in: 1..100, message: 'Value should be between 0 and 4' }
  validates :first_name, :last_name, length: { in: 2..30 }
  validates :description, length: { in: 3..1000 }
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'email adress please' }
  belongs_to :city
  has_many :gossips
  has_many :comments
  has_many :LierPrivateMessageUsers
  has_many :received_messages, through: :LierPrivateMessageUsers, source: :private_message
  has_many :likes
  has_many :liked_gossips, through: :likes, source: :gossip
  has_many :sent_messages, foreign_key: 'sender_id', class_name: 'PrivateMessage'
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
