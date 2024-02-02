class Auction < ApplicationRecord
  after_update :update_status
  belongs_to :user
  has_many :products
  has_many :bids , dependent: :destroy

  enum status: { unapproved: "unapproved", approved: "approved", pending: "pending",live: "live", ended: "ended", rejected: "rejected"}

  def update_status
    if self.status== :approved
      if Time.current < start_time
        self.status = :pending
      elsif Time.current > end_time
        self.status = :ended
      else
        self.status = :live
      end
      save
    end
  end
end
