class CreateAuctions < ActiveRecord::Migration[7.1]
  def change
    create_table :auctions do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :minimum_bids
      t.string :status

      t.timestamps
    end
  end
end
