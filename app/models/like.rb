class Like < ApplicationRecord
  belongs_to :gossips ,optional:true
  belongs_to :comments, optional:true
end
