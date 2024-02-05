class AuctionStatusJob < ApplicationJob
  queue_as :default

  def perform
    Auction.where(status: 'approved').each do |auction|
      auction.update_status
    end
  end
end
