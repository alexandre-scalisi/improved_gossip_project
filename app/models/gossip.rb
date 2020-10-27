class Gossip < ApplicationRecord
  validates :title, :content, presence: true
  validates :title, length:{in: 3..14}
  validates :content, length:{in: 1..1000}
  belongs_to :user
  has_many :JoinTableTagGossips
  has_many :tags, through: :JoinTableTagGossips
end
