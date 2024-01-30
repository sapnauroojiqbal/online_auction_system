class Auction < ApplicationRecord
  belongs_to :seller, class_name: 'User'
  has_many :bids
end
