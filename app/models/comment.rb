class Comment < ApplicationRecord
  validates :content, presence: true, length: { in: 3..1000 }
  belongs_to :gossip
  belongs_to :user
  has_many :likes
end
