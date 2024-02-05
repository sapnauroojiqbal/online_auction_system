namespace :auctions do
  desc 'Update auction status'
  task update_status: :environment do
    Auction.update_status
  end
end
