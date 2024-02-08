class CreateAuctions < ActiveRecord::Migration[7.1]
  def change
    create_table :auctions do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :minimum_bids, null: false, default: 1
      t.string :status, null: false, default: "unapproved"

      t.timestamps
    end
  end
end
