class Comment < ApplicationRecord
  validates :content, presence: true, length: {in: 3..1000}
end
