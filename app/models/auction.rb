class Auction < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :bids , dependent: :destroy
end
