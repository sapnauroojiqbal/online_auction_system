# frozen_string_literal: true

class AddAuctionToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :auction_id, :bigint, null: true
  end
end
