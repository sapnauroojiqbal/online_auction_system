class Auction < ApplicationRecord
  belongs_to :seller, class_name: 'User'
  belongs_to :product
  has_many :bids
end
