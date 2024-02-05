class Auction < ApplicationRecord
  belongs_to :user
  has_many :products, foreign_key: 'auction_id'
  has_many :bids, dependent: :destroy

  enum status: { unapproved: "unapproved", approved: "approved", live: "live", ended: "ended", rejected: "rejected"}


  def update_status
    if status == "approved" && start_time <= Time.current && end_time >= Time.current
      update(status: 'live')
    elsif end_time < Time.current
      update(status: 'ended')
      determine_winner_and_send_emails
    end
    broadcast_update
  end

  def broadcast_update
    ActionCable.server.broadcast("auctions_channel", { auction_id: id, status: status })
  end

  def determine_winner_and_send_emails
    products.each do |product|
      highest_bid = product.bids.maximum('amount')

      if highest_bid.present?
        winner_bid = product.bids.find_by(amount: highest_bid)
        winner = winner_bid&.user

        if winner.present?
          product.update(status: 'sold', sold_to_id: winner.id)
          send_winner_email(winner)
        end

        loser_bids = product.bids.where.not(user: winner)
        losers = loser_bids.map(&:user)

        if losers.present?
        send_losers_email(losers)
        end
      else
        product.update(status: 'approved')
      end
    end
  end

  def send_winner_email(winner)
    AuctionsMailer.winner_email(winner, self).deliver_now
  end

  def send_losers_email(losers)
    AuctionsMailer.losers_email(losers, self).deliver_now
  end
end
