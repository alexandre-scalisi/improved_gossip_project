class City < ApplicationRecord
  validates :name, :zip_code, presence:true
  validates :name, length:{ in: 1..35  }
  validates :zip_code, format: { with: /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/, message: "please enter a valid french zip code" }
  has_many :users
end
