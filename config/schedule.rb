set :output, "./log/cron.log"

every 1.minute do
  rake "auctions:update_status"
end
