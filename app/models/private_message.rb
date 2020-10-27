class PrivateMessage < ApplicationRecord
  validates :content, presence:true, length:{in: 1..500}
  has_many :LierPrivateMessageUsers
  has_many :receivers,through: :LierPrivateMessageUsers,source: :user
  belongs_to :sender, class_name: "User"
  

end
