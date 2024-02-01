class AddUserIdToAuctions < ActiveRecord::Migration[7.1]
  def change
    add_reference :auctions, :user, null: false, foreign_key: true
  end
end
