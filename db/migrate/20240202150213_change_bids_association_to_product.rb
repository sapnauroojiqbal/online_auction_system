# frozen_string_literal: true

class ChangeBidsAssociationToProduct < ActiveRecord::Migration[6.0]
  def change
    remove_reference :bids, :auction, index: true, foreign_key: true
    add_reference :bids, :product, null: false, index: true, foreign_key: true
  end
end
