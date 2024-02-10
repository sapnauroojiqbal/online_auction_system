# frozen_string_literal: true

class AuctionStatusJob < ApplicationJob
  queue_as :default

  def perform
    Auction.where(status: 'approved').find_each(&:update_status)
  end
end
