class AuctionEndingJob < ApplicationJob
  queue_as :default

  def perform(auction_id)
    auction = Auction.find(auction_id)
    auction.update_status
  end
end
