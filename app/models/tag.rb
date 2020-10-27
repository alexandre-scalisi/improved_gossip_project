class Tag < ApplicationRecord
  validates :title, presence:true, length: {in: 2..18}
  has_many :JoinTableTagGossips
  has_many :gossips, through: :JoinTableTagGossips
end
