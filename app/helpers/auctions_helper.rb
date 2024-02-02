module AuctionsHelper
  def countdown_timer(auction)
    now = Time.zone.now
    if auction.status== "approved"
      if auction.start_time > Time.zone.now
        return "Auction not started yet! will start at #{auction.start_time}"
      end
    seconds_remaining = (auction.end_time - now).to_i

    return "Auction ended!" if seconds_remaining <= 0

    seconds_per_day = 86400
    seconds_per_hour = 3600
    seconds_per_minute = 60

    days = seconds_remaining / seconds_per_day
    hours = (seconds_remaining % seconds_per_day) / seconds_per_hour
    minutes = (seconds_remaining % seconds_per_hour) / seconds_per_minute
    seconds = seconds_remaining % seconds_per_minute

    "#{days.floor} days, #{hours.floor} hours, #{minutes.floor} minutes, #{seconds.floor} seconds"
    else
      "not approved so it is not live yet"
    end
  end
end
