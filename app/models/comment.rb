class Comment < ApplicationRecord
  validates :content, presence: true, length: { in: 3..1000, message: "must be between 3 and 1000 characters" }
  belongs_to :gossip
  belongs_to :user
  has_many :likes
end
