every 1.minute do
  runner "AuctionEndingJob.perform_later"
end
